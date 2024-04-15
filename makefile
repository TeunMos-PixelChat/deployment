# variables
RESOURCE_GROUP=PixelChat_US
CLUSTER_NAME=PixelChat-Cluster

# General commands
authorize: k-auth
deploy: k-apply
undeploy: k-delete

remake: k-delete k-apply
deauthorize:
	kubectl delete -f kubernetes/dockerconfigjson.yaml

nuke: k-delete deauthorize

# Kubectl commands
pods:
	kubectl get pods
services:
	kubectl get services


deploy-local: pull d-deploy
	

pull:
	docker pull ghcr.io/teunmos-pixelchat/frontend:develop
	docker pull ghcr.io/teunmos-pixelchat/gateway:develop
	docker pull ghcr.io/teunmos-pixelchat/message-api:develop

update: pull k-delete k-apply



# kubernetes deployment commands
k-apply:
	kubectl apply -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml
k-delete:
	kubectl delete -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml

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




# MiniKube commands
mini-start:
	minikube start --driver=docker --container-runtime=containerd
mini-stop:
	minikube stop
mini-dashboard:
	minikube dashboard