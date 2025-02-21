from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import UserCreate, UserResponse, LoginRequest
from ..crud import create_user, get_user_by_email
from ..auth import verify_password, generate_access_token

router = APIRouter()

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