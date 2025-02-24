from fastapi import FastAPI
from auth import router as auth_router
from api.routes import router as api_router

app = FastAPI(title="Twitch FastAPI Backend")

app.include_router(auth_router, prefix="/auth", tags=["auth"])
app.include_router(api_router, prefix="/api", tags=["api"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
