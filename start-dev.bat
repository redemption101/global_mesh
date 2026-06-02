@echo off
REM Start both frontend and backend for development
REM This script opens the backend in one window and frontend in another

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║   AETHERION MESH HUB - Development Environment Starter       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check if we're in the right directory
if not exist "global_mesh_backend" (
    echo ERROR: Run this script from the global_mesh directory
    echo Current directory: %cd%
    exit /b 1
)

echo Starting backend and frontend...
echo.

REM Start backend in new window
echo [1/2] Starting Erlang backend on port 4000...
start "Erlang Backend" cmd /k "cd global_mesh_backend && rebar3 shell"

REM Wait a moment for backend to start
timeout /t 3 /nobreak

REM Start frontend in new window (using Python HTTP server)
echo [2/2] Starting frontend on port 3000...
echo Note: Using Python HTTP server. Make sure Python is installed.
start "Pure HTML Frontend" cmd /k "cd frontend && python -m http.server 3000"

echo.
echo ✅ Environment started!
echo.
echo Frontend:  http://localhost:3000
echo Backend:   http://localhost:4000
echo.
echo To stop: Close the command windows or press Ctrl+C in each
echo.
pause
