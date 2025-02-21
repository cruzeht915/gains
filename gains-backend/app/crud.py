from sqlalchemy.orm import Session, joinedload
from .models import User, Workout, Exercise
from .schemas import UserCreate, WorkoutCreate, WorkoutResponse
from datetime import datetime

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

#Get User by email
def get_user_by_email(db: Session, email:str):
    return db.query(User).filter(User.email == email).first()

#Get User by ID
def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()


#Create user workout
def create_workout(db: Session, workout: WorkoutCreate):
    #Creates workout entry
    new_workout = Workout(
        user_id = workout.user_id,
        date = datetime.now()
    )
    db.add(new_workout)
    db.commit()
    db.refresh(new_workout)

    #Add exercises to Workout
    for exercise in workout.exercises:
        new_exercise = Exercise(
            workout_id = new_workout.id, #Link to Workout
            name = exercise.name,
            sets = exercise.sets,
            reps = exercise.reps,
            weight = exercise.weight
        )
        db.add(new_exercise)
    return new_workout

#Get a User's workouts
def get_user_workouts(db: Session, user_id: int):
    return db.query(Workout).filter(Workout.user_id==user_id).all()

#Get a workout by id
def get_workout_by_id(db: Session, workout_id: int):
    return db.query(Workout).options(joinedload(Workout.exercises)).filter(Workout.id==workout_id).first() #Gets around Lazy Loading

