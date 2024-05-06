#!/bin/bash

docker build \
    --build-arg REACT_APP_API_URL="api" \
    --build-arg REACT_APP_TEST="testing testing 123" \
    --build-arg REACT_APP_AUTH0_DOMAIN="pixelchat-dev.eu.auth0.com" \
    --build-arg REACT_APP_AUTH0_CLIENT_ID="0USfxnxTptK8Pmz5Gm89hgW3a6Kt3wma" \
    --build-arg REACT_APP_AUTH0_AUDIENCE="pixelchat-gateway-identifier" \
    --file ./frontend/Dockerfile --tag pixelchat-frontend:latest ./frontend

docker build -t pixelchat-message-api:latest -f ./message-api/Dockerfile ./message-api
docker build -t pixelchat-gateway:latest -f ./gateway/Dockerfile ./gateway