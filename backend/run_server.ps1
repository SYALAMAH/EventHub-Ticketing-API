# ============================================================================
# EventHub &bull; RESTful API Server Launch Script
# Course: SWC3633 / SWC4443 Web API Development
# Universiti Poly-Tech Malaysia (UPTM)
# ============================================================================

$Host.UI.RawUI.WindowTitle = "EventHub REST API Server (Port 8000)"

Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "  UPTM Web API Development - Event Ticketing & Venue Booking System" -ForegroundColor Yellow
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[1] XAMPP Apache Web Portal:" -ForegroundColor Green
Write-Host "    http://localhost/frontend/  OR  http://localhost/event_ticketing/" -ForegroundColor White
Write-Host ""
Write-Host "[2] FastAPI RESTful Web API Documentation:" -ForegroundColor Green
Write-Host "    Swagger UI : http://127.0.0.1:8000/docs" -ForegroundColor White
Write-Host "    ReDoc Spec : http://127.0.0.1:8000/redoc" -ForegroundColor White
Write-Host ""
Write-Host "[3] Database Target: event_ticketing_db (Port 3306 / 3307)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Starting Uvicorn Server on http://127.0.0.1:8000 (Press Ctrl+C to Stop)..." -ForegroundColor Yellow
Write-Host "----------------------------------------------------------------------------" -ForegroundColor Gray

# Ensure we are in C:\xampp\htdocs
Set-Location -Path "C:\xampp\htdocs"

# Launch Uvicorn server
python -m uvicorn backend.main:app --reload --host 127.0.0.1 --port 8000
