from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, ARRAY, Float
from sqlalchemy.orm import relationship
from datetime import datetime
from .database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, nullable=False)
    password_hash = Column(String, primary_key=True, index=True)

    # Relationship to Workouts (One user can have many workouts)
    workouts = relationship("Workout", back_populates="user")

class Workout(Base):
    __tablename__ = "workouts"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    date = Column(DateTime, default= datetime.now())

    users = relationship("User", back_populates="workouts")
    exercises = relationship("Exercise", back_populates="workout")

    
    
class Exercise(Base):
    __tablename__ = "exercises"

    id = Column(Integer, primary_key=True, index=True)
    workout_id = Column(Integer, ForeignKey("workouts.id"))
    name = Column(String, nullable=False)
    sets = Column(Integer)
    reps = Column(ARRAY(Integer))
    weights = Column(ARRAY(Float))

    workout = relationship("Workout", back_populates="exercises") 
