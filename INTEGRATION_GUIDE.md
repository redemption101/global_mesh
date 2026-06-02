# Aetherion MeshHub - Frontend/Backend Integration Guide

## Overview

This project integrates a **pure HTML** frontend with an Erlang backend using HTTP communication. The frontend (running on port 3000) communicates with the backend (running on port 4000) via REST API endpoints.

## Architecture

### Frontend
- **Type**: Pure HTML + Vanilla JavaScript
- **Port**: 3000 (development)
- **Styling**: Tailwind CSS (via CDN)
- **Icons**: Lucide Icons (via CDN)
- **No Build Step**: Open `index.html` directly or serve via HTTP

### Backend
- **Language**: Erlang/OTP
- **Framework**: Cowboy HTTP server
- **Port**: 4000
- **API**: REST endpoints via HTTP

## Prerequisites

### Frontend
- Any modern web browser (Chrome, Firefox, Safari, Edge)
- Python 3 (for simple HTTP server) OR Node.js http-server OR any HTTP server

### Backend
- Erlang/OTP 26+ (https://www.erlang.org)
- Rebar3 (Erlang build tool)

## Setup Instructions

### 1. Backend Setup

```bash
cd global_mesh_backend

# Build the backend
rebar3 compile

# Start the backend in development mode
rebar3 shell
```

The backend will start on **http://localhost:4000**

Key API Endpoints:
- **GET /api/ignition** - Health check and simple deployment
- **POST /api/ignition** - Deployment with architecture ID payload
- **OPTIONS /api/ignition** - CORS preflight

### 2. Frontend Setup

No installation needed! Just serve the HTML file:

**Option A: Python (recommended)**
```bash
cd frontend
python -m http.server 3000
```

**Option B: Node.js http-server**
```bash
cd frontend
npx http-server -p 3000
```

**Option C: PHP**
```bash
cd frontend
php -S localhost:3000
```

**Option D: Direct file**
- Simply open `frontend/index.html` in your browser (but you'll need to run it on a server for API calls to work properly)

The frontend will start on **http://localhost:3000**

### 3. Quick Start Script

**Windows:**
```bash
start-dev.bat
```

**macOS/Linux:**
```bash
chmod +x start-dev.sh
./start-dev.sh
```

## API Communication

### Frontend JavaScript

The deployment handler in `index.html` communicates with the backend:

```javascript
async function handleIgnitionDeploy() {
    const response = await fetch("http://localhost:4000/api/ignition", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            architectureId: state.selectedArch.id,
            timestamp: Date.now()
        })
    });
    
    const data = await response.json();
    // Handle response...
}
```

### Backend API Response Format

All API responses follow this JSON structure:

```json
{
  "status": "DEPLOYED_SUCCESSFULLY|ERROR",
  "lockdown_key": "512-bit JWT token",
  "message": "Human-readable message",
  "architectureId": "ARCH-ID-123",
  "timestamp": 1234567890
}
```

## CORS Configuration

The backend is configured to accept requests from any origin (`*`). For production, update the CORS headers in [ignition_handler.erl](./global_mesh_backend/apps/mesh_api/src/ignition_handler.erl#L67) to restrict to specific domains.

## Troubleshooting

### Frontend can't connect to backend

1. **Verify backend is running**:
   ```bash
   curl http://localhost:4000/api/ignition
   ```
   Should return JSON response

2. **Check frontend is served over HTTP**:
   - Don't use `file://` protocol (won't work due to CORS)
   - Use `http://localhost:3000` instead
   - Verify Python/Node.js HTTP server is running

3. **Check browser console**:
   - Open DevTools (F12) → Console tab
   - Look for CORS or connection errors

### Deployment logs show "ERROR: Failed to connect"

- Verify Erlang backend is running (`rebar3 shell`)
- Check that the backend is listening on port 4000
- Try manual curl request to verify connectivity

### Erlang backend won't start

- Ensure Erlang/OTP 26+ is installed: `erl -version`
- Check for port conflicts: `netstat -an | grep 4000`
- Review error logs for missing dependencies

## Development Workflow

1. **Start Backend** (Terminal 1):
   ```bash
   cd global_mesh_backend && rebar3 shell
   ```

2. **Start Frontend** (Terminal 2):
   ```bash
   cd frontend && python -m http.server 3000
   ```

3. **Open Browser**:
   - Navigate to http://localhost:3000

4. **Make Changes**:
   - Frontend: Edit `index.html`, refresh browser (changes take effect immediately)
   - Backend: Stop with Ctrl+C, rebuild and restart

5. **Test Deployment**:
   - Click "EXECUTE INTERSTELLAR IGNITION" button in UI
   - Check deployment logs for success/errors

## File Structure

```
global_mesh/
├── frontend/
│   ├── index.html           # Main frontend (Pure HTML + Vanilla JS)
│   ├── README.md            # Frontend documentation
│   └── .env.production      # Optional: Production settings
│
└── global_mesh_backend/
    ├── apps/
    │   └── mesh_api/
    │       └── src/
    │           ├── ignition_handler.erl    # API endpoint handler
    │           ├── mesh_api_app.erl        # App initialization
    │           └── mesh_api_sup.erl        # Supervisor
    ├── config/
    │   ├── sys.config         # System configuration
    │   └── vm.args            # VM arguments
    └── rebar.config           # Erlang build configuration
```

## Deploying to Production

### Frontend (Pure HTML)

**Docker:**
```dockerfile
FROM nginx:alpine
COPY frontend/index.html /usr/share/nginx/html/
EXPOSE 80
```

**AWS S3 + CloudFront:**
1. Upload `index.html` to S3
2. Set up CloudFront distribution
3. Point DNS to CloudFront

**Vercel/Netlify:**
- Simply upload the `index.html` file
- Set environment variable for backend URL if needed

**Traditional Server (Apache/Nginx):**
- Copy `index.html` to web root
- Ensure CORS headers are properly configured

### Backend (Erlang)

```bash
cd global_mesh_backend
rebar3 release
```

Output in `_build/default/rel/global_mesh/`

## Environment Configuration

For production, update the backend URL in `index.html`:

```javascript
// Change this line in handleIgnitionDeploy()
const response = await fetch("http://your-production-backend.com:4000/api/ignition", {
```

Or use a configuration endpoint to fetch the backend URL at runtime.

## Next Steps for Enhancement

### 1. Additional API Endpoints
```erlang
- GET /api/health              - System health check
- GET /api/architectures       - List all architectures
- GET /api/architectures/:id   - Get specific architecture
- POST /api/architectures      - Create new architecture
- PUT /api/architectures/:id   - Update architecture
- DELETE /api/architectures/:id - Delete architecture
```

### 2. Authentication & Authorization
- Implement JWT-based authentication
- Add user session management
- Protect sensitive endpoints

### 3. Database Integration
- Connect to CockroachDB
- Implement data persistence
- Add query optimizations

### 4. Real-time Updates
- WebSocket support for live updates
- Server-sent events (SSE) for notifications
- Real-time transaction streaming

### 5. Error Handling & Logging
- Structured logging (JSON format)
- Error tracking and monitoring
- Request tracing

## Resources

- [Vanilla JavaScript Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [Fetch API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Cowboy HTTP Server](https://ninenines.eu/docs/en/cowboy/)
- [Erlang Documentation](https://www.erlang.org/docs)
- [Rebar3 Guide](https://rebar3.readme.io/)
