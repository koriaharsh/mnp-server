from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
import models
from database import engine
from Routers import auth, stream

app = FastAPI()

origins = [
    "http://10.224.1.174:4000",
    "http://localhost:3000",
    "http://10.224.1.212:3000",
    "http://10.224.1.174:3000"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


models.Base.metadata.create_all(bind=engine)
app.include_router(auth.router)
app.include_router(stream.router)
