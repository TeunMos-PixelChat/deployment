# Deployment

> The deployment is done automatically by the CI/CD pipeline. This document is to provide information on how the deployment is done.

## Used Tools

- **Github Actions**: for CI/CD pipeline
- **Docker**: for containerization
- **Github Packages**: for storing docker images
- **Azure kubernetes Service (AKS)**: for hosting the application

## Deployment Steps (CI/CD Pipeline)

1. **Build Docker Image**: The docker image is built and pushed automatically to Github Packages on every push to the `main` or `develop` branch (see [docker-push.yml](./frontend/.github/workflows/docker-push.yml)).
2. **Deploy to AKS**: The image is deployed to AKS automatically on every push to the `main` or `develop`. This is done by just restarting the specific deployment in AKS. The reason why this works is because all the deployments are using the `develop` or `main` tag, which is updated on every push to the respective branch and because all the deployments have the `imagePullPolicy` set to `Always`. (see [kubernetes-deploy.yml](./frontend/.github/workflows/kubernetes-deploy.yml)).