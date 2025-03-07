# Origoss DevOps Homework

Developed by **Andor Margitics** ([GitHub: mrgitics](https://github.com/mrgitics))

## Prerequisites
- **Note**: These instructions assume a Linux environment. For Windows, use WSL2 with a Linux distro.
- **Go**: make sure Go installed.
- **Docker**: make sure Docker installed.
- **Minikube**: Install with `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube`.
- **kubectl**: Install with `curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && sudo install kubectl /usr/local/bin/kubectl`.

## Cluster Provisioning (for Task 4)
- Start Minikube: `minikube start`
- Verify: `kubectl get nodes`

## Task 1: Simple HTTP Server
- **File**: `src/main.go`
- **Language**: Go (preferred by Origoss)
- **Description**: Responds with "Hello, World!" at `/` on port 8080.
- **Run**: `./scripts/run_task1.sh`
- **Verify**: Script outputs `"Hello, World!"` via `curl`

## Task 2: Dockerize the HTTP Server
- **File**: `Dockerfile`
- **Description**: Multi-stage build using `golang:1.24.1` and `scratch` for a lightweight image.
- **Build**: `docker build -t hello-world-server .`
- **Run**: `./scripts/run_task2.sh`
- **Verify**: Script outputs `"Hello, World!"` via `curl`

## Task 3: CI Pipeline
- **Goal**: Build and push the Docker image to a registry.
- **File**: `.github/workflows/ci.yaml`
- **Platform**: GitHub Actions
- **Registry**: Docker Hub
- **Description**: Builds and pushes the image on tagged pushes (e.g., `v1.0`).
- **Setup**:
  - In your GitHub repo, go to **Settings > Secrets and variables > Actions > New repository secret(password)-New repository variable(username).
  - Add these secrets:
    - `DOCKER_USERNAME`: Your Docker Hub username.
    - `DOCKER_PASSWORD`: Your Docker Hub Personal Access Token (PAT).
- **Trigger**: `git tag v1.0 && git push origin v1.0`
- **Image**: `<your-username>/hello-world-server:v1.0`
- **Verify**: `docker pull <your-username>/hello-world-server:v1.0`

## Task 4: Kubernetes Deployment
- **Goal**: Deploy the HTTP server to a Kubernetes cluster.
- **File**: `kubernetes/deployment.yaml`
- **Platform**: Minikube
- **Description**: Deploys the HTTP server with 2 replicas using a Deployment and a NodePort Service.
- **Run**: `./scripts/run_task4.sh`
- **Image**: `mrgitics/hello-world-server:v1.0`
- **Verify**: Script outputs the NodePort URL (e.g., `http://127.0.0.1:XXXXX`) and `"Hello, World!"` via `curl`

## Task 5: Terraform Deployment
- **Goal**: Use Terraform to deploy the HTTP server to Minikube.
- **File**: `terraform/main.tf`
- **Platform**: Minikube
- **Description**: Deploys the HTTP server with 2 replicas and a NodePort Service using the Terraform Kubernetes provider (resources named `hello-world-server-tf` and `hello-world-service-tf` to distinguish from Task 4).
- **Run**: `./scripts/run_task5.sh`
- **Image**: `mrgitics/hello-world-server:v1.0`
- **Verify**: Script outputs the NodePort URL (e.g., `http://127.0.0.1:XXXXX`) and `"Hello, World!"` via `curl`

## Cleanup
- **Script**: `./scripts/cleanup.sh`
- **Description**: Removes all resources created by Tasks 2, 4, and 5:
  - Task 2: Stops and removes the Docker container.
  - Task 4: Deletes Kubernetes deployment and service.
  - Task 5: Destroys Terraform-managed resources.
