# Deployment repository

> #### Don't forget to run `git submodule update --init --recursive` after cloning this repository, or use `git clone --recurse-submodules` to clone it.


> See [Deployment.md](Deployment.md) for more (CI/CD) deployment specific information.

This repo contains all other repositories and the configuration files used in the PixelChat project for deployment with `docker-compose` and `kubernetes`.


> The deployment is done automatically by the CI/CD pipeline. This document is to provide information on how the deployment is done.

## Used Tools

- **Github Actions**: for CI/CD pipeline
- **Docker**: for containerization
- **Github Packages**: for storing docker images
- ~~**Azure kubernetes Service (AKS)**: for hosting the application~~ 
- **Netlab with k3s**: for hosting the application
- **Artillery**: for performance testing

## Deployment Steps (Done automatically in the CI/CD Pipeline)

1. **Endpoint/Unit Test**: The services are individually tested automatically on every push or pull request to the `main` or `develop` branch (see [run-tests.yml](./message-api/.github/workflows/run-tests.yml).
2. **Build Docker Image**: The docker image is built and pushed automatically to Github Packages on every push to the `main` or `develop` branch (see [docker-push.yml](./frontend/.github/workflows/docker-push.yml)).
3. **Deploy to AKS**: The image is deployed to AKS automatically on every push to the `main` or `develop`. This is done by just restarting the specific deployment in AKS. The reason why this works is because all the deployments are using the `develop` or `main` tag, which is updated on every push to the respective branch and because all the deployments have the `imagePullPolicy` set to `Always`. (see [kubernetes-deploy.yml](./frontend/.github/workflows/kubernetes-deploy.yml)).
4. **Performance Test**: The performance test is done automatically on every push to the `main` or `develop` branch and is done on the deployed application in the NetLab Environment. It uses artillery to do the performance test (see [Performance-test-kubernetes.yml](./message-api/.github/workflows/performance-test-kubernetes.yml))

## Running the project locally (with docker-compose)

The project can be run locally using docker-compose.

1. Clone this repository (with submodules!!)

2. run this make command to build the images and start the containers using docker-compose

```bash
make d-deploy
```

3. The frontend should be available (through the gateway) at `http://localhost`