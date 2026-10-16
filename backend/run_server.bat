@echo off
title EventHub REST API Server (Port 8000)
cd /d "C:\xampp\htdocs"
echo ============================================================================
echo   UPTM Web API Development - Event Ticketing & Venue Booking System
echo ============================================================================
echo.
echo [1] Apache Website:  http://localhost/frontend/
echo [2] Swagger UI:      http://127.0.0.1:8000/docs
echo.
echo Starting FastAPI Uvicorn Server on port 8000...
python -m uvicorn backend.main:app --reload --host 127.0.0.1 --port 8000
pause
