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
