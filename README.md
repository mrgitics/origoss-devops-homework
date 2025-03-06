# Origoss DevOps Homework

Developed by **Andor Margitics** ([GitHub: mrgitics](https://github.com/mrgitics)) for the Origoss DevOps Homework.

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
- **Run**: `go run src/main.go`
- **Test**: `curl http://localhost:8080`

## Task 2: Dockerize the HTTP Server
- **File**: `Dockerfile`
- **Description**: Multi-stage build using `golang:1.24.1` and `scratch` for a lightweight image.
- **Build**: `docker build -t hello-world-server .`
- **Run**: `docker run -p 8080:8080 hello-world-server`
- **Test**: `curl http://localhost:8080`

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
- **Description**: Deploys the HTTP server with 2 replicas using a Deployment with rolling updates and a NodePort Service.
- **Deployment Steps**:
  - Apply: `kubectl apply -f kubernetes/deployment.yaml`
  - Check: `kubectl get deployments` (expect 2/2 ready) and `kubectl get pods` (expect 2 pods)
  - Access: `minikube service hello-world-service --url`
  - Note: Keep the terminal open when using `minikube service --url` with the Docker driver on Linux.
  - Update Version: Edit `image` in `deployment.yaml` (e.g., `mrgitics/hello-world-server:v1.1`), then `kubectl apply -f kubernetes/deployment.yaml`
- **Image**: `mrgitics/hello-world-server:v1.0`
- **Note**: To use your own image, run Task 3’s CI with your `DOCKER_USERNAME` and `DOCKER_PASSWORD` (PAT), then update `image` to `<your-username>/hello-world-server:v1.0`.
- **Verify**: `curl <minikube-service-url>` returns `"Hello, World!"`

## Task 5: Terraform Deployment
- **Goal**: Use Terraform to deploy the HTTP server to Minikube.
- **File**: `terraform/main.tf`
- **Platform**: Minikube
- **Description**: Deploys the HTTP server with 2 replicas and a NodePort Service using the Terraform Kubernetes provider (resources named `hello-world-server-tf` and `hello-world-service-tf` to distinguish from Task 4).
- **Deployment Steps**:
  - Start Minikube: `minikube start`
  - Navigate to Terraform dir: `cd terraform`
  - Initialize: `terraform init`
  - Apply: `terraform apply` (type `yes` to confirm)
  - Check: `kubectl get deployments` (expect `hello-world-server-tf` 2/2 ready) and `kubectl get pods`
  - Access: `minikube service hello-world-service-tf --url` (e.g., `curl http://127.0.0.1:38047`)
- **Image**: `mrgitics/hello-world-server:v1.0`
- **Verify**: `curl <minikube-service-url>` returns `"Hello, World!"` from either pod
