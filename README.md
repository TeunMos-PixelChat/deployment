# Deploymen repository

> ### Don't forget to run `git submodule update --init --recursive` after cloning this repository, or use `git clone --recurse-submodules` to clone it.

This repo contains all other repositories and the configuration files used in the PixelChat project for deployment with `docker-compose` and `kubernetes`.

# Running the project

> **Note:** Some of the following commands only work on Linux. If you are using Windows, you can use the `WSL` (Windows Subsystem for Linux) to run them for now. I'm working on a solution to make it work on Windows without `WSL`.

> Some of the following commands require `make` to be installed. If you don't have it, you can run the commands in the `Makefile` manually.

There are main ways to run the entire project with all its services:

## Docker Compose

To run the project with `docker-compose`, you need to have `docker` and `docker-compose` installed. Then, you can run the following make commands:

```bash
make d-build # bash docker_build_containers.sh (script that builds all containers)

make d-deploy # docker-compose up -d
```

## Kubernetes

To run the project with `kubernetes`, you need to have `kubectl` and `minikube` installed. Then, you can run the following make commands:

```bash
make start # minikube start --driver=docker --container-runtime=containerd

make build # bash kubernetes_build_containers.sh (script that builds all containers)

make deploy # kubectl apply -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml
```

## Running the services individually

You can also run the services individually. Each service has its own `README.md` file with instructions on how to run it.
