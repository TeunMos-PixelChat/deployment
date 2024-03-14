#!/bin/bash

eval $(minikube docker-env)

# Use the environment variables set by `eval` in subsequent commands
docker build --build-arg REACT_APP__MESSAGE_API_URL="api" -t pixelchat-frontend:latest -f ./frontend/dockerfile ./frontend
docker build -t pixelchat-message-api:latest -f ./message-api/dockerfile ./message-api
docker build -t pixelchat-gateway:latest -f ./gateway/dockerfile ./gateway

# Reset the environment variables
eval $(minikube docker-env -u)
