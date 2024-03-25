#!/bin/bash

eval $(minikube docker-env)

# Use the environment variables set by `eval` in subsequent commands
docker build --build-arg REACT_APP_API_URL="api" -t pixelchat-frontend:latest -f ./frontend/Dockerfile ./frontend
docker build -t pixelchat-message-api:latest -f ./message-api/Dockerfile ./message-api
docker build -t pixelchat-gateway:latest -f ./gateway/Dockerfile ./gateway

# Reset the environment variables
eval $(minikube docker-env -u)


# TODO: eval command is not always working
# A way to do this is to build the images to docker-hub instead of locally
# which is how it's supposed to work