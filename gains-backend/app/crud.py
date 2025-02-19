from sqlalchemy.orm import Session
from .models import User, Workout, Exercise
from .schemas import UserCreate, WorkoutCreate, WorkoutResponse

from passlib.context import CryptContext

pwd_context = CryptContext(schemes=['bcrypt'], deprecated="auto",)

#Hash password
def hash_password(password: str) -> str:
    return pwd_context.hash(password)

#Create new User
def create_user(db: Session, user: UserCreate):
    hashed_password = hash_password(user.password)
    db_user = User(email=user.email, password_hash=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

#get User by email
def get_user_by_email(db: Session, email:str):
    return db.query(User).filter(User.email == email).first()

#get User by ID
def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()

