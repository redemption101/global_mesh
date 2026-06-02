# Aetherion MeshHub Frontend - Pure HTML

This is a pure HTML + Vanilla JavaScript frontend. No build step needed!

## Quick Start

1. **Start the backend** (in another terminal):
   ```bash
   cd global_mesh_backend
   rebar3 shell
   ```
   Backend runs on: http://localhost:4000

2. **Serve the frontend** (simple HTTP server):
   ```bash
   # Using Python 3
   python -m http.server 3000
   
   # Or using Node.js http-server
   npx http-server -p 3000
   
   # Or using PHP
   php -S localhost:3000
   ```
   Frontend runs on: http://localhost:3000

3. **Open in browser**: http://localhost:3000

## Architecture

- `index.html` - Complete frontend (HTML + CSS + Vanilla JavaScript)
- No build process required
- No dependencies to install
- Pure vanilla JavaScript with Tailwind CSS via CDN

## How It Works

The `handleIgnitionDeploy()` function in `index.html` communicates with your Erlang backend:

```javascript
// POST request to backend with architecture ID
const response = await fetch("http://localhost:4000/api/ignition", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
        architectureId: state.selectedArch.id,
        timestamp: Date.now()
    })
});
```

Backend responds with JWT token and deployment status.

## Deployment

Simply copy `index.html` to any web server:
- **Apache/Nginx**: Copy to `www` directory
- **AWS S3 + CloudFront**: Upload as static site
- **Vercel/Netlify**: Drop in the file (no build config needed)
- **Docker**: Serve via simple HTTP container

```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 3000
```

## Environment

Update the backend URL in `index.html` if needed:
```javascript
const response = await fetch("http://localhost:4000/api/ignition", {
```

For production, change to your production backend URL.
