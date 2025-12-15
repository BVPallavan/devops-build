#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
IMAGE_NAME="devops-tasks-app"
IMAGE_TAG="latest"

# Build Docker image
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo "Docker image $IMAGE_NAME:$IMAGE_TAG built successfully!"
