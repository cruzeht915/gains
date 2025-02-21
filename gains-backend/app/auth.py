from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from passlib.context import CryptContext
from jose import jwt, JWTError, ExpiredSignatureError
import os
from datetime import timedelta, datetime
from sqlalchemy.orm import Session
from .database import get_db
from .models import User
from dotenv import load_dotenv

load_dotenv()

ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
SECRET_KEY = os.getenv("SECRET_KEY")

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2scheme = OAuth2PasswordBearer(tokenUrl="users/login")

#Verifies password
def verify_password(password, hased_password):
    return pwd_context.verify(password, hased_password)

#Creates JWT access token
def generate_access_token(data: dict, expires_delta: timedelta = None):
    to_decode = data.copy()
    expire = datetime.now()+ (expires_delta if expires_delta else timedelta(minutes=20))
    to_decode.update({"exp": expire})
    return jwt.encode(to_decode, SECRET_KEY, algorithm=ALGORITHM)

#Validate JWT access token and gets user
def get_current_user(token: str = Depends(oauth2scheme), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("sub")
        if email is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
        user = db.query(User).filter(email == User.email).first()
        if user is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="User not found")
        return {"id": user.id, "email": user.email}
    except ExpiredSignatureError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token expired")
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token invalid")