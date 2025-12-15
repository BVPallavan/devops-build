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
