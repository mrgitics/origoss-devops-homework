#!/bin/bash
echo "Running Task 1: Simple HTTP Server"

# Get the directory of this script and move to the project root
SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.." || exit 1

# Run the Go server from the src directory
go run src/main.go &
sleep 2
curl http://localhost:8080#!/bin/bash

