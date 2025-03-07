#!/bin/bash
set -e
echo "Cleaning up Task 2: Dockerized HTTP Server"

SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.."

CONTAINER_ID=$(docker ps -q --filter "publish=8080" --filter "ancestor=hello-world-server")
if [ -n "$CONTAINER_ID" ]; then
    docker stop "$CONTAINER_ID"
    docker rm "$CONTAINER_ID"
    echo "Container stopped and removed"
else
    echo "No running container found for hello-world-server"
fi

echo "Cleaning up Task 4: Kubernetes Deployment"
kubectl delete -f kubernetes/deployment.yaml --timeout=60s
echo "Task 4 resources deleted (deployment: hello-world-server, service: hello-world-service)"

echo "Cleaning up Task 5: Terraform Deployment"
cd terraform
terraform destroy -auto-approve
cd - >/dev/null
echo "Task 5 resources deleted (deployment: hello-world-server-tf, service: hello-world-service-tf)"
