#!/bin/bash
set -e

IMAGE_NAME="devops-tasks-app"
IMAGE_TAG="latest"

# Pull image from registry
#echo "Pulling Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
#docker pull $IMAGE_NAME:$IMAGE_TAG

# Stop and remove old container if exists
if docker ps -q -f name=devops-tasks-app-dev; then
	echo "Stopping devops-tasks-app-dev..."
	docker stop devops-tasks-app-dev || true
	docker rm devops-tasks-app-dev || true
fi

# Stop and remove old container if exists
if docker ps -q -f name=devops-tasks-app-prod; then
	echo "Stopping devops-tasks-app-prod..."
	docker stop devops-tasks-app-prod || true
	docker rm devops-tasks-app-prod || true
fi

# Run new container
echo "Launching my-react-$ENV..."
ENVIRONMENT=$ENV docker-compose up -d --build

# Verify container is running
docker ps -f name=devops-tasks-app-$ENV

