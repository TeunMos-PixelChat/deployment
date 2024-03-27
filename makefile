
# Builds the containers for the kubernetes cluster
build:
	bash kubernetes_build_containers.sh

deploy: build k-apply
remake: k-delete k-apply

pull:
	docker pull ghcr.io/teunmos-pixelchat/frontend:develop
	docker pull ghcr.io/teunmos-pixelchat/gateway:develop
	docker pull ghcr.io/teunmos-pixelchat/message-api:develop

update: pull k-delete k-apply

# Kubernetes commands
start:
	minikube start --driver=docker --container-runtime=containerd
stop:
	minikube stop
dashboard:
	minikube dashboard

# kubernetes deployment commands
k-apply:
	kubectl apply -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml
k-delete:
	kubectl delete -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml

k-frontend:
	minikube service pixelchat-frontend
k-gateway:
	minikube service pixelchat-gateway
k-message-api:
	minikube service pixelchat-message-api

k-auth:
	kubectl create -f kubernetes/dockerconfigjson.yaml

# Docker compose commands
d-build:
	bash docker_build_containers.sh
d-deploy: d-build
	docker-compose up -d
d-delete:
	docker-compose down

# Azure kubernetes commands for the PixelChat cluster
aks-stop:
	az aks stop --resource-group PixelChat_US --name PixelChat-Cluster

aks-start:
	az aks start --resource-group PixelChat_US --name PixelChat-Cluster

aks-status:
	@az aks show --resource-group PixelChat_US --name PixelChat-Cluster --query "powerState.code" | jq

aks-credentials:
	az aks get-credentials --resource-group PixelChat_US --name PixelChat-Cluster

aks-credentials-unset:
	kubectl config unset users.clusterUser_PixelChat-Cluster_PixelChat_US