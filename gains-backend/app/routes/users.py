from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from jose import jwt
import os
from datetime import timedelta, datetime
from ..database import get_db
from ..schemas import UserCreate, UserResponse, LoginRequest
from ..crud import create_user, get_user_by_email
from fastapi.security import OAuth2PasswordBearer
from dotenv import load_dotenv

load_dotenv()

ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
SECRET_KEY = os.getenv("SECRET_KEY")

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2scheme = OAuth2PasswordBearer(tokenUrl="users/login")

router = APIRouter()

#Verifies password
def verify_password(password, hased_password):
    return pwd_context.verify(password, hased_password)

#Creates JWT access token
def generate_access_token(data: dict, expires_delta: timedelta = None):
    to_decode = data.copy()
    expire = datetime.now()+ (expires_delta if expires_delta else timedelta(minutes=20))
    to_decode.update({"exp": expire})
    return jwt.encode(to_decode, SECRET_KEY, algorithm=ALGORITHM)

@router.post("/register", response_model=UserResponse)
def register(user: UserCreate, db: Session=Depends(get_db)):
    db_user = get_user_by_email(db, user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="User already exists")
    new_user = create_user(db, user)
    return new_user

@router.post("/login")
def login(request: LoginRequest, db: Session=Depends(get_db)):
    user = get_user_by_email(db, request.email)
    if not user or not verify_password(request.password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid Credentials")
    access_token = generate_access_token(data= {"sub": user.email})
    return {"access_token": access_token, "token_type": "bearer"}