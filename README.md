# Origoss DevOps Homework

## Task 1: Simple HTTP Server
- **File**: `src/main.go`
- **Language**: Go (preferred by Origoss)
- **Description**: Responds with "Hello, World!" at `/` on port 8080.
- **Run**: `go run src/main.go`
- **Test**: `curl http://localhost:8080`

## Task 2: Dockerize the HTTP Server
- **File**: `Dockerfile`
- **Description**: Multi-stage build using `golang:1.24.1` and `scratch` for a lightweight image.
- **Build**: `docker build -t hello-world-server .`
- **Run**: `docker run -p 8080:8080 hello-world-server`
- **Test**: `curl http://localhost:8080`

## Task 3: CI Pipeline
- **Goal**: Build and push the Docker image to a registry (per exercise 3).
- **File**: `.github/workflows/ci.yaml`
- **Platform**: GitHub Actions
- **Registry**: Docker Hub
- **Description**: Builds and pushes the image on tagged pushes (e.g., `v1.0`).
- **Setup**:
  - In your GitHub repo, go to **Settings > Secrets and variables > Actions > New repository secret(password)-New repository variable(username).
  - Add these secrets:
    - `DOCKER_USERNAME`: Your Docker Hub username (e.g., `mrgitics`).
    - `DOCKER_PASSWORD`: Your Docker Hub password or Personal Access Token (PAT).
  - The workflow uses `${{ vars.DOCKER_USERNAME }}` to dynamically set the Docker Hub username in the image tag.
- **Trigger**: `git tag v1.0 && git push origin v1.0`
- **Image**: `<your-username>/hello-world-server:v1.0`
- **Verify**: `docker pull <your-username>/hello-world-server:v1.0`
