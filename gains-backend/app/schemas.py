from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime

class UserBase(BaseModel):
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int
    
    class Config:
        orm_mode = True

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class ExerciseBase(BaseModel):
    name: str
    sets: int
    reps: List[int]
    weigths: List[float]

class WorkoutCreate(BaseModel):
    user_id: int
    exercises: List[ExerciseBase]

class WorkoutResponse(WorkoutCreate):
    id: int
    date: datetime
    
    class Config:
        orm_mode = True