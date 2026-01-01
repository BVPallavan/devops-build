#!/bin/bash
ENV=$1

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

