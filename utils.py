import httpx
from config import TWITCH_CLIENT_ID, TWITCH_CLIENT_SECRET, TWITCH_VALIDATE_URL

async def get_twitch_user_info(access_token: str):
    """Fetches the authenticated user's info from Twitch API."""
    async with httpx.AsyncClient() as client:
        headers = {"Authorization": f"Bearer {access_token}", "Client-ID": TWITCH_CLIENT_ID}
        response = await client.get("https://api.twitch.tv/helix/users", headers=headers)

        if response.status_code != 200:
            return None
         # Parse and return user data
        user_data = response.json()
        print("Twitch User Data:", user_data)
        return user_data

async def refresh_twitch_token(refresh_token: str):
    """Refreshes an expired Twitch access token."""
    async with httpx.AsyncClient() as client:
        response = await client.post(
            "https://id.twitch.tv/oauth2/token",
            data={
                "client_id": TWITCH_CLIENT_ID,
                "client_secret": TWITCH_CLIENT_SECRET,
                "refresh_token": refresh_token,
                "grant_type": "refresh_token",
            },
        )
        if response.status_code != 200:
            return None
        return response.json()

async def validate_twitch_token(access_token: str):
    """Validates a Twitch access token."""
    async with httpx.AsyncClient() as client:
        response = await client.get(TWITCH_VALIDATE_URL, headers={"Authorization": f"Bearer {access_token}"})
        return response.json() if response.status_code == 200 else None
