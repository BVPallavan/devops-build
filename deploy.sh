#!/bin/bash
ENV=$1

#IMAGE_NAME="devops-tasks-app"
#IMAGE_TAG="latest"

# Pull image from registry
#echo "Pulling Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
#docker pull $IMAGE_NAME:$IMAGE_TAG

# Stop and remove old container if exists
if docker ps -q -f name=devops-app-dev; then
	echo "Stopping devops-app-dev..."
	docker stop devops-app-dev
	docker rm devops-app-dev
fi

# Stop and remove old container if exists
if docker ps -q -f name=devops-app-prod; then
	echo "Stopping devops-app-prod..."
	docker stop devops-app-prod
	docker rm devops-app-prod
fi

# Run new container
echo "Launching devops-app-$ENV..."
ENVIRONMENT=$ENV docker-compose up -d --build

# Verify container is running
docker ps -f name=devops-tasks-app-$ENV

