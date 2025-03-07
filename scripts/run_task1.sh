#!/bin/bash
echo "Running Task 1: Simple HTTP Server"

SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.." || exit 1

go run src/main.go &
sleep 2
curl http://localhost:8080

