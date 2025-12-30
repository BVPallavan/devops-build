#!/bin/bash
set -e

IMAGE_NAME="devops-tasks-app"
IMAGE_TAG="latest"

# Pull image from registry
echo "Pulling Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
docker pull $IMAGE_NAME:$IMAGE_TAG

# Stop and remove old container if exists
docker stop $IMAGE_NAME || true
docker rm $IMAGE_NAME || true

# Run new container
docker run -d --name $IMAGE_NAME -p 80:80 $IMAGE_NAME:$IMAGE_TAG

echo "Deployment completed successfully on local EC2!"


#!/bin/bash
ENV=$1

echo "Starting deployment for environment: $ENV"

# Stop & remove any old container (dev or prod)
if docker ps -q -f name=my-react-dev; then
  echo "Stopping my-react-dev..."
  docker stop my-react-dev
  docker rm my-react-dev
fi

if docker ps -q -f name=my-react-prod; then
  echo "Stopping my-react-prod..."
  docker stop my-react-prod
  docker rm my-react-prod
fi

# Run new container with docker-compose
echo "Launching my-react-$ENV..."
ENVIRONMENT=$ENV docker-compose up -d --build

# Verify container is running
docker ps -f name=my-react-$ENV
