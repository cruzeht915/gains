from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import WorkoutCreate, WorkoutResponse
from ..auth import get_current_user
from ..crud import create_workout, get_user_workouts, get_workout_by_id
from fastapi.security import OAuth2PasswordBearer

router = APIRouter()

#Create a new workout (Requires authentication)
@router.post("/", response_model=WorkoutResponse)
def create_new_workout(workout: WorkoutCreate, db: Session=Depends(get_db), user: dict=Depends(get_current_user)):
    return create_workout(db, workout)

#Get all workouts for the logged in user (Requires authentication)
@router.get("/", response_model=list[WorkoutResponse])
def get_workouts(db: Session=Depends(get_db), current_user: dict=Depends(get_current_user)):
    return get_user_workouts(db, current_user["id"])

#Get a specific workout by id
@router.get("/", response_model=WorkoutResponse)
def get_workout(workout_id: int, db: Session=Depends(get_db), current_user: dict=Depends(get_current_user)):
    workout = get_workout_by_id(db, workout_id)
    if not workout:
        raise HTTPException(status_code=404, detail="Workout not found")
    if workout.user_id != current_user["id"]:
        raise HTTPException(status_code=403, detail="Not authorized to view this workout!")



