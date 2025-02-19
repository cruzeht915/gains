from fastapi import FastAPI
from app.routes import users, workouts, ai
from app.database import Base, engine

#Initialzize DB tables
Base.metadata.create_all(bind=engine)

app = FastAPI()

#Include API routes
app.include_router(users.router, prefix="/users")
#app.include_router(workouts.router, prefix="/workouts")
#app.include_router(ai.router, prefix="/ai")

@app.get("/")
def home():
    return {"message": "GIGA Gains API is running"}
    