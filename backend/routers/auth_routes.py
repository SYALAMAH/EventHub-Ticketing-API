"""
Authentication Endpoints
Handles user registration, login, profile retrieval, and API Key regeneration.
Course: SWC3633 / SWC4443 Web API Development
"""
from fastapi import APIRouter, Depends, HTTPException, status
import pymysql

from backend.database import get_db, serialize_row
from backend.models import UserRegister, UserLogin
from backend.auth import (
    hash_password,
    verify_password,
    create_access_token,
    generate_api_key,
    get_current_user
)

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/register", status_code=status.HTTP_201_CREATED)
def register_user(payload: UserRegister, db: pymysql.Connection = Depends(get_db)):
    """Registers a new customer or organiser account."""
    cursor = db.cursor()
    cursor.execute("SELECT user_id FROM users WHERE email = %s", (payload.email.lower(),))
    if cursor.fetchone():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"An account with email '{payload.email}' already exists."
        )

    hashed_pw = hash_password(payload.password)
    api_prefix = "org" if payload.role == "organiser" else "cus"
    api_key = generate_api_key(api_prefix)
    user_name = payload.display_name

    cursor.execute("""
        INSERT INTO users (full_name, email, password_hash, role, api_key, phone)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (user_name, payload.email.lower(), hashed_pw, payload.role, api_key, payload.phone))

    user_id = cursor.lastrowid
    token = create_access_token(data={"sub": str(user_id), "role": payload.role, "email": payload.email.lower()})

    return {
        "status": "success",
        "message": "User registered successfully.",
        "data": {
            "access_token": token,
            "token_type": "bearer",
            "user": {
                "user_id": user_id,
                "full_name": user_name,
                "email": payload.email.lower(),
                "role": payload.role,
                "api_key": api_key,
                "phone": payload.phone
            }
        }
    }

@router.post("/login", status_code=status.HTTP_200_OK)
def login_user(payload: UserLogin, db: pymysql.Connection = Depends(get_db)):
    """Logs in an administrator, organiser, or customer."""
    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE email = %s", (payload.email.lower(),))
    user_row = cursor.fetchone()

    if not user_row or not verify_password(payload.password, user_row["password_hash"], email=user_row["email"]):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password credentials."
        )

    user = serialize_row(user_row)
    token = create_access_token(data={"sub": str(user["user_id"]), "role": user["role"], "email": user["email"]})

    return {
        "status": "success",
        "message": "Login successful.",
        "data": {
            "access_token": token,
            "token_type": "bearer",
            "user": {
                "user_id": user["user_id"],
                "full_name": user["full_name"],
                "email": user["email"],
                "role": user["role"],
                "api_key": user.get("api_key"),
                "phone": user.get("phone")
            }
        }
    }

@router.get("/me", status_code=status.HTTP_200_OK)
def get_my_profile(current_user: dict = Depends(get_current_user)):
    """Returns the authenticated user's profile and active API key."""
    return {
        "status": "success",
        "data": current_user
    }
