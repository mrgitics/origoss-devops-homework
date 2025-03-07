#!/bin/bash
echo "Running Task 5: Terraform Deployment"

SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.." || exit 1


minikube start
cd terraform || exit 1
terraform init
terraform apply -auto-approve
cd - >/dev/null 

echo "Waiting for deployment to be ready (up to 2 minutes)..."
kubectl wait --for=condition=available deployment/hello-world-server-tf --timeout=300s
kubectl get deployments
kubectl get pods
echo "Checking pod status..."
sleep 10
PODS_READY=$(kubectl get pods -l app=hello-world-server-tf --no-headers | grep -c "1/1.*Running")
if [ "$PODS_READY" -eq 2 ]; then
    echo "Pods are ready—opening service URL in background..."
    minikube service hello-world-service-tf --url > /tmp/task5_service_url.txt 2>/dev/null &
    MINIKUBE_PID=$!
    sleep 5
    SERVICE_URL=$(cat /tmp/task5_service_url.txt | head -n 1)
    echo "Service URL: $SERVICE_URL"
    echo "Testing with curl..."
    curl "$SERVICE_URL" || echo "Curl failed—check the URL or pod logs"
    kill $MINIKUBE_PID 2>/dev/null
    rm -f /tmp/task5_service_url.txt
else
    echo "Error: Pods not ready—checking details..."
    kubectl describe pod -l app=hello-world-server-tf
    echo "Check logs with 'kubectl logs -l app=hello-world-server-tf' for more info"
    exit 1
fi
