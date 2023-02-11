from sqlalchemy import Boolean, Column, Integer, String, ForeignKey, Date, Time, CheckConstraint, TIMESTAMP
from sqlalchemy.orm import relationship, validates
from database import Base
import re


class Users(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, CheckConstraint('email!=""'), unique=True, index=True)
    username = Column(String, unique=True, index=True)
    full_name = Column(String)
    gender = Column(String)
    age = Column(Integer)
    hashed_password = Column(String)
    is_active = Column(Boolean, default=True)
    phone_number = Column(String)
    role_id = Column(Integer, ForeignKey("user_roles.id"))
    roles = relationship("Role", back_populates="users")
    address = relationship("Address", back_populates="user_address")

    @validates('username')
    def validate_username(self,key,username):
        result = re.search("^[a-zA-Z0-9]([.-](?![.-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$", username)
        if not result:
            raise ValueError("failed username validation")
        return username

    @validates('email')
    def validate_email(self,key,email_address):
        result = re.search("^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)$", email_address)
        if not result:
            raise ValueError("failed email validation")
        return email_address

    @validates("first_name")
    def validate_firstname(self,key,first_name):
        result = re.search("^[a-zA-Z]+$", first_name)
        if not result:
            raise ValueError("failed first name validation")
        return first_name

    @validates("last_name")
    def validate_firstname(self, key, last_name):
        result = re.search("^[a-zA-Z]+$", last_name)
        if not result:
            raise ValueError("failed last name validation")
        return last_name


class Role(Base):
    __tablename__ = "user_roles"

    id = Column(Integer, primary_key=True, index=True)
    role = Column(String, unique=True, index=True)
    users = relationship("Users", back_populates="roles")

    @validates("role")
    def validate_role(self,key,role):
        if role not in ["ADMIN", "DOCTOR", "PATIENT"]:
            raise ValueError("failed role validation")


class Address(Base):
    __tablename__ = "address"
    id = Column(Integer, primary_key=True, index=True)
    address1 = Column(String)
    address2 = Column(String)
    city = Column(String)
    state = Column(String)
    country = Column(String)
    postalcode = Column(Integer)
    user_id = Column(Integer, ForeignKey("users.id"))

    user_address = relationship("Users", back_populates="address")


class PasswordReset(Base):
    __tablename__ = "password_reset"
    id = Column(Integer, primary_key=True, index=True)
    reset_token = Column(String)
    is_verified = Column(Boolean)
    token_creation_time = Column(TIMESTAMP)