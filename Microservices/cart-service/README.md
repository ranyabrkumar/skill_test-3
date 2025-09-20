## Dockerizing the User Service

Follow these steps to build and run the user-service using Docker:

### 1. Create a Dockerfile

- Set a working directory using `WORKDIR`.
- Install dependencies (e.g., `RUN npm install` for Node.js).
- Expose the correct port using `EXPOSE`.
- Include a valid `CMD` instruction to start the service.

Example Dockerfile:
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

### 2. Build the Docker Image

```sh
docker build -t user-service .
```

### 3. Run the Container in the Background with Port Mapping

```sh
docker run -d -p 3000:3000 user-service
```
