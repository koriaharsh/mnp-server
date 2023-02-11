import sys
sys.path.append("..")

from fastapi import FastAPI, Depends, HTTPException, status, APIRouter, Request
from pydantic import BaseModel, EmailStr
from typing import Optional, List
import models
from passlib.context import CryptContext
from sqlalchemy.orm import Session, validates
from database import engine, sessionLocal
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from datetime import datetime, timedelta
from jose import jwt, JWTError
from fastapi_mail import ConnectionConfig, FastMail, MessageSchema, MessageType
from Routers.body import body, email_verification_template
import re
import pyotp
import time
import random
import string
import hashlib


SECRET_KEY = "kakakaljdnsui78oufojcnjporu11"
ALGORITHM = "HS256"

class CreateUser(BaseModel):
    username: str
    email: str
    full_name: str
    gender: str
    age: int
    phone_number: Optional[str]
    password: str
    user_role: str


class ResetPassword(BaseModel):
    username: str
    password: str
    reset_token: str


conf = ConnectionConfig(
    MAIL_USERNAME ="neuroxr.cdacdelhi",
    MAIL_PASSWORD = "wszrxfbvycwdmzck",
    MAIL_FROM = "neuroxr.cdacdelhi@gmail.com",
    MAIL_PORT = 465,
    MAIL_SERVER = "smtp.gmail.com",
    MAIL_STARTTLS = False,
    MAIL_SSL_TLS = True,
    USE_CREDENTIALS = True,
    VALIDATE_CERTS = True
)

#wszrxfbvycwdmzck

bcrypt_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

models.Base.metadata.create_all(bind=engine)

oauth_bearer = OAuth2PasswordBearer(tokenUrl="token")

router = APIRouter(
    prefix="/auth",
    tags=["auth"],
    responses={401: {"user": "Not authorized"}}
)


totp = pyotp.TOTP("harshkoriajijijiji", 6, None, None, None, 300)

def get_db():
    try:
        db = sessionLocal()
        yield db
    finally:
        db.close()


def generate_otp():
    return totp.now()

def verify_otp(otp):
    print(totp.interval)
    return totp.verify(otp)


def get_password_hash(password):
    return bcrypt_context.hash(password)


def verify_password(plain_password, hashed_password):
    return bcrypt_context.verify(plain_password, hashed_password)


def authenticate_user(username: str, password: str, db):
    user = db.query(models.Users).filter(models.Users.username == username).first()

    if not user:
        return False
    if not verify_password(password, user.hashed_password):
        return False
    return user


def create_access_token(username: str, user_id: int, expires_delta: Optional[timedelta] = None):

    encode = {
        "sub": username,
        "id": user_id
    }
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    encode.update({"exp": expire})
    return jwt.encode(encode, SECRET_KEY, algorithm=ALGORITHM)


async def get_current_user(token: str = Depends(oauth_bearer)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        user_id: int = payload.get("id")
        if username is None or user_id is None:
            raise get_user_exception()
        return {"username": username, "id": user_id}
    except JWTError:
        raise get_user_exception()


def create_reset_token():
    str = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=12))
    result = hashlib.sha256(str.encode())
    return result.hexdigest()

class RollChecker:
    def __init__(self, allowed_roles: List):
        self.allowed_roles = allowed_roles

    def __call__(self, user: models.Users = Depends(get_current_user), db: Session = Depends(get_db)):
        print(user['id'])
        user_role = db.query(models.Role).join(models.Users).filter(models.Users.id == user['id']).first()
        role = user_role.role
        print(role)
        if role not in self.allowed_roles:
            raise HTTPException(status_code=403, detail="Operation not permitted")


allow_only_admin = RollChecker(["ADMIN"])
allow_doctor_and_patient = RollChecker(["USER", "INVIGILATOR"])

@router.get("/")
async def hello():
    otp = generate_otp()
    return {"message": "Welcome", "otp": otp}


@router.get("/resend/otp")
async def re_send_otp():
    otp = generate_otp()
    uri = totp.provisioning_uri()
    return {"otp": otp, "uri": uri}

@router.post("/verify/otp/")
async def otp_verification(request: Request, db: Session = Depends(get_db)):
    data = await request.json()
    print(data['otp'])
    time_remaining = totp.interval - datetime.now().timestamp() % totp.interval
    print(time_remaining)
    is_valid = verify_otp(data['otp'])
    if not is_valid:
        raise invalid_otp_exception()
    token = create_reset_token()
    print(token)
    token_model = models.PasswordReset()
    token_model.reset_token = token
    token_model.is_verified = False
    token_model.token_creation_time = datetime.now()

    db.add(token_model)
    db.commit()

    return {"message": "OTP verified successfully", "reset_token": token}


@router.post("/send/otp")
async def send_verification_otp(request: Request):
    data = await request.json()
    email = data['email']
    message = MessageSchema(
        subject="E-mail verification email",
        recipients=[email],
        body=email_verification_template(generate_otp()),
        subtype=MessageType.html)
    fm = FastMail(conf)
    await fm.send_message(message)
    return "OTP sent successfully"


@router.post("/create/user", status_code=201)
async def create_new_user(create_user: CreateUser, db: Session = Depends(get_db)):
    user = db.query(models.Users).filter(models.Users.username == create_user.username).first()
    if user is not None:
        raise duplicate_username_exception()

    result = re.search("^^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$", create_user.password)
    if not result:
        raise ValueError("failed password validation")

    create_user_model = models.Users()
    role_model = db.query(models.Role).filter(models.Role.role == create_user.user_role).first()
    create_user_model.email = create_user.email
    create_user_model.username = create_user.username
    create_user_model.full_name = create_user.full_name
    create_user_model.gender = create_user.gender
    create_user_model.age = create_user.age
    create_user_model.phone_number = create_user.phone_number
    create_user_model.hashed_password = get_password_hash(create_user.password)
    create_user_model.role_id = role_model.id
    create_user_model.is_active = True
    create_user_model.is_verified = False

    db.add(create_user_model)
    db.commit()
    return f"User created successfully!"


@router.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(),
                                 db: Session = Depends(get_db)):
    user = authenticate_user(form_data.username, form_data.password, db)
    print()
    if not user:
        raise token_exception()
    token_expires = timedelta(minutes=20)
    token = create_access_token(user.username,
                                user.id,
                                expires_delta=token_expires)
    return {"token": token, "fullname": user.full_name, "email": user.email, "role": user.roles.role}


@router.get("/check/{username}")
async def check_username_available(username: str, db: Session = Depends(get_db)):
    user = db.query(models.Users).filter(models.Users.username == username).first()
    if user is None:
        return True
    return False


@router.post("/forget_password")
async def send_verification_email_to_reset_password(request: Request, db: Session = Depends(get_db)):
    data = await request.json()
    username = data['username']
    user = db.query(models.Users).filter(models.Users.username == username).first()
    if user is None:
        raise get_user_exception()
    email = user.email
    message = MessageSchema(
        subject="E-mail verification email",
        recipients=[email],
        body=email_verification_template(generate_otp()),
        subtype=MessageType.html)
    fm = FastMail(conf)
    await fm.send_message(message)

    return "OTP sent successfully"


@router.post("/reset_password")
async def reset_password(reset_obj: ResetPassword, db: Session = Depends(get_db)):
    token_model = db.query(models.PasswordReset).filter(models.PasswordReset.reset_token == reset_obj.reset_token).filter(models.PasswordReset.is_verified == False).first()
    if token_model is None:
        raise HTTPException(status_code=403, detail="Could not validate token")
    token_model.is_verified = True

    db.add(token_model)

    user = db.query(models.Users).filter(models.Users.username == reset_obj.username).first()
    if user is None:
        raise get_user_exception()
    user.hashed_password = get_password_hash(reset_obj.password)

    db.add(user)
    db.commit()
    return "Password changed successfully"



#Exeptions

def get_user_exception():
    credential_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"}
    )
    return credential_exception


def token_exception():
    token_exception_response = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Incorrect username or password",
        headers={"WWW-Authenticate": "Bearer"}
    )
    return token_exception_response


def duplicate_username_exception():
    duplicate_username_response = HTTPException(
        status_code=409,
        detail="Duplicate entry not allowed"
    )
    return duplicate_username_response


def invalid_otp_exception():
    invalid_otp_response = HTTPException(
        status_code=403,
        detail="OTP verification failed"
    )
    return invalid_otp_response
