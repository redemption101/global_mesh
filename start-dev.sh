#!/bin/bash

# Start both frontend and backend for development
# This script runs on macOS/Linux

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   AETHERION MESH HUB - Development Environment Starter       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check if we're in the right directory
if [ ! -d "global_mesh_backend" ]; then
    echo "ERROR: Run this script from the global_mesh directory"
    echo "Current directory: $(pwd)"
    exit 1
fi

echo "Starting backend and frontend..."
echo ""

# Start backend in background
echo "[1/2] Starting Erlang backend on port 4000..."
(cd global_mesh_backend && rebar3 shell) &
BACKEND_PID=$!

# Wait for backend to start
sleep 3

# Start frontend using Python HTTP server
echo "[2/2] Starting frontend on port 3000..."
(cd frontend && python3 -m http.server 3000) &
FRONTEND_PID=$!

echo ""
echo "✅ Environment started!"
echo ""
echo "Frontend:  http://localhost:3000"
echo "Backend:   http://localhost:4000"
echo ""
echo "To stop: Press Ctrl+C"
echo ""

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID
