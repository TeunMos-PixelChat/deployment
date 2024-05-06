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

## Running the project locally

The project can be run locally using docker-compose.

#### 1. Clone this repository (if you haven't already)
```bash
git clone https://github.com/TeunMos-PixelChat/deployment.git
```

#### 2. Get a github personal access token with the `read:packages` scope. 
See [here](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-docker-registry#authenticating-to-github-packages) for more information.

#### 3. Login to github packages with the token
```bash
docker login docker.pkg.github.com -u <username> -p <token>
```

#### 4. Run the compose file
```bash
docker-compose up -d
```

#### 5. Access the frontend
The frontend (via the gateway) can be accessed on http://localhost/ in your browser using the default port 80.
