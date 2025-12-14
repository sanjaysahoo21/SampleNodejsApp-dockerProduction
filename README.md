## Objective
This project demonstrates how to package a simple Node.js web application into a Docker container.  
The goal is to understand Docker basics such as writing a Dockerfile, building images, running containers, using environment variables, and pushing images to Docker Hub.

---

## Technologies Used
- Node.js
- Express
- Docker
- Docker Hub

---

## Project Structure
```

SampleNodejsApp-dockerProduction/
│
├── server.js
├── package.json
├── package-lock.json
├── Dockerfile
├── .dockerignore
└── README.md

```

---

## Run Application Without Docker

Install dependencies:
```

npm install

```

Start the application:
```

npm start

```

Open in browser:
```

http://localhost:5000

```

---

# SampleNodejsApp — Docker-ready Node.js app

A minimal Express app packaged for Docker with clear instructions for local development and production usage.

## Quick summary
- App listens on `process.env.PORT` (default `5000`).
- Supports running inside Docker and mapping any host port to the container port.

## Prerequisites
- Node.js (for local development)
- Docker (for container builds and runs)

## Install & run locally
1. Install dependencies:

	npm install

2. Start the app:

	npm start

3. Open your browser at `http://localhost:5000` (or the port printed by the app).

If you prefer development auto-reload, run:

	npm run dev

## Environment variables
- `PORT` — port the app listens on (default: `5000`).
- `NODE_ENV` — set to `production` for production optimizations.

Example running locally with a custom port:

```
PORT=8080 npm start
```

On Windows PowerShell use:

```
$env:PORT=8080; npm start
```

## Docker

Build the image (from project root):

```
docker build -t sample-node-app:latest .
```

Run the container mapping host port 8080 to the app (container listens on 5000 by default):

```
docker run -d -p 8080:5000 --name sample-node-app sample-node-app:latest
```

If you want the app to listen on a different container port, set `PORT` and map the same port on the host:

```
docker run -d -e PORT=8081 -p 8081:8081 --name sample-node-app sample-node-app:latest
```

Notes:
- `EXPOSE` in the Dockerfile is documentation only — Docker port mapping is controlled with `-p`.
- Ensure the app's `server.js` uses `process.env.PORT || 5000`.

## Common troubleshooting
- App works locally but not via Docker on a different host port: confirm you mapped the host port to the container port (example: `-p 8080:5000`).
- If `npm start` fails inside the container, ensure `package.json` contains a `start` script that runs `node server.js`.
- If you used `npm ci` in Docker without a `package-lock.json`, the build will fail — use `npm install` or add a lockfile.

## Production tips
- Run with `NODE_ENV=production` in the container: `docker run -e NODE_ENV=production ...`.
- Use a non-root user inside the image for improved security (recommended in Dockerfile).
- Add a healthcheck and logging to integrate with orchestrators.

## Files of interest
- `server.js` — main app entry, should accept `process.env.PORT`.
- `Dockerfile` — how the image is built.
- `package.json` — ensure `start` & `dev` scripts exist.

---