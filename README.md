
# Twitch OAuth FastAPI Backend

This is a FastAPI-based backend that authenticates users via Twitch's OAuth and fetches their user information. The backend uses the `twitch-api` to retrieve user details like email, username, and profile image.

## Features
- Twitch OAuth Authentication
- Fetches user profile data: username, display name, email, etc.
- No database needed, only access to Twitch API via OAuth

---

## **Prerequisites**

Before you start, you need:

- **Python 3.7+**
- **Twitch Developer Account**  
  Create an application in the [Twitch Developer Console](https://dev.twitch.tv/console/apps) to get a **Client ID** and **Client Secret**.

---

## **Installation and Setup**

### **1. Clone the Repository**
Clone this repository to your local machine:

```bash
git clone https://github.com/your-username/twitch-fastapi-backend.git
cd twitch-fastapi-backend
```

### **2. Install Dependencies**
Make sure you have [pipenv](https://pipenv.pypa.io/en/latest/) installed. If not, you can install it with:

```bash
pip install pipenv
```

Then, install the required dependencies:

```bash
pipenv install
```

### **3. Set Up Environment Variables**
Create a `.env` file in the root directory of the project, and fill in the following details:

```bash
TWITCH_CLIENT_ID=your_actual_twitch_client_id
TWITCH_CLIENT_SECRET=your_actual_twitch_client_secret
TWITCH_REDIRECT_URI=http://localhost:8000/auth/callback
TWITCH_SCOPES=user:read:email
```

You can get your **Client ID** and **Client Secret** from the [Twitch Developer Console](https://dev.twitch.tv/console/apps).

### **4. Start the Development Server**

Now, run the FastAPI development server:

```bash
pipenv run uvicorn main:app --reload
```

The app will be running on **http://localhost:8000**.

---

## **Usage**

### **1. Authenticate with Twitch**
Visit the following URL in your browser to initiate the OAuth login flow:

[http://localhost:8000/auth/login](http://localhost:8000/auth/login)

You will be redirected to Twitch’s login page. After successfully logging in and authorizing your app, Twitch will redirect you back to **http://localhost:8000/auth/callback?code=...**.

### **2. View User Data**
After the authentication is complete, the app will exchange the `code` for an **access token** and fetch your user data from Twitch. This will be displayed in your browser as a JSON response containing your user info like username, display name, email, and profile image.

Example Response:
```json
{
    "access_token": "your_access_token_here",
    "user_info": {
        "data": [
            {
                "id": "12345678",
                "login": "your_username",
                "display_name": "YourDisplayName",
                "email": "your@email.com",
                "profile_image_url": "https://static-cdn.jtvnw.net/jtv_user_pictures/...",
                "description": "This is my Twitch bio!",
                "view_count": 1000
            }
        ]
    }
}
```

### **3. Check User Data in Console**
You can also see the user data printed in the server logs (in your terminal) as the `print()` statement inside `get_twitch_user_info` function will show the data.

---

## **Testing the Application**
To test the application, follow these steps:

1. **Start the development server** using `pipenv run uvicorn main:app --reload`.
2. Visit **http://localhost:8000/auth/login** in your browser to authenticate with Twitch.
3. After successful login and redirect, you should see your **user data** returned as a JSON response.

---

## **Troubleshooting**

- **Invalid Client ID / Client Secret**: Make sure the `TWITCH_CLIENT_ID` and `TWITCH_CLIENT_SECRET` in the `.env` file match the ones in the Twitch Developer Console. Restart the server after editing `.env`.
- **redirect_mismatch error**: Ensure the `redirect_uri` in your `.env` matches exactly with the one in the Twitch Developer Console's OAuth settings.
- **Access Token Issues**: If you encounter errors related to the access token, try regenerating the **Client Secret** in the Twitch Developer Console and update it in your `.env` file.

---