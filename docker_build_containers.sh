#!/bin/bash

docker build --build-arg REACT_APP__MESSAGE_API_URL="api" -t pixelchat-frontend:latest -f ./frontend/Dockerfile ./frontend
docker build -t pixelchat-message-api:latest -f ./message-api/Dockerfile ./message-api
docker build -t pixelchat-gateway:latest -f ./gateway/Dockerfile ./gateway