# Combined repository

> ### Don't forget to run `git submodule update --init --recursive` after cloning this repository, or use `git clone --recurse-submodules` to clone it.

This repo contains all other repositories used in the PixelChat project for deployment with `docker-compose` and `kubernetes`.

# Running the project

There are main ways to run the entire project with all its services:

## Docker Compose

To run the project with `docker-compose`, you need to have `docker` and `docker-compose` installed. Then, you can run the following make commands:

```bash
make d-build # RUNS: bash docker_build_containers.sh (script that builds all containers)

make d-deploy # RUNS: docker-compose up -d
```

## Kubernetes

To run the project with `kubernetes`, you need to have `kubectl` and `minikube` installed. Then, you can run the following make commands:

```bash
make start # RUNS: minikube start --driver=docker --container-runtime=containerd

make build # RUNS: bash kubernetes_build_containers.sh (script that builds all containers)

make deploy # RUNS: kubectl apply -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml
```

## Running the services individually

You can also run the services individually. Each service has its own `README.md` file with instructions on how to run it.
