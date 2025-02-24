import httpx
from fastapi import APIRouter, Depends, Request, HTTPException
from utils import get_twitch_user_info
from config import TWITCH_CLIENT_ID, TWITCH_CLIENT_SECRET, TWITCH_REDIRECT_URI, TWITCH_AUTH_URL, TWITCH_TOKEN_URL, TWITCH_VALIDATE_URL

router = APIRouter()

@router.get("/login")
async def login():
    """Redirects user to Twitch OAuth login."""
    return {
        "url": f"{TWITCH_AUTH_URL}?client_id={TWITCH_CLIENT_ID}&redirect_uri={TWITCH_REDIRECT_URI}&response_type=code&scope=user:read:email"
    }

@router.get("/callback")
async def callback(code: str):
    """Handles Twitch OAuth callback and exchanges code for token."""
    async with httpx.AsyncClient() as client:
        response = await client.post(TWITCH_TOKEN_URL, data={
            "client_id": TWITCH_CLIENT_ID,
            "client_secret": TWITCH_CLIENT_SECRET,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": TWITCH_REDIRECT_URI
        })
        token_data = response.json()
        access_token = token_data["access_token"]
        if response.status_code != 200:
            raise HTTPException(status_code=400, detail="Failed to get token")
        # Fetch user info from Twitch API
        user_info = await get_twitch_user_info(access_token)

        return {"access_token": access_token, "user_info": user_info}


@router.get("/validate")
async def validate_token(request: Request):
    """Validates Twitch token."""
    token = request.headers.get("Authorization")
    if not token:
        raise HTTPException(status_code=401, detail="Missing Authorization header")
    
    async with httpx.AsyncClient() as client:
        response = await client.get(TWITCH_VALIDATE_URL, headers={"Authorization": token})
        if response.status_code != 200:
            raise HTTPException(status_code=401, detail="Invalid token")
        return response.json()
