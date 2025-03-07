#!/bin/bash
set -e
echo "Running Task 2: Dockerize the HTTP Server"

SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.."

docker build -t hello-world-server .
docker run -d -p 8080:8080 hello-world-server
sleep 2
curl http://localhost:8080
