
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


# Docker compose commands
d-build:
	bash docker_build_containers.sh
d-deploy: d-build
	docker-compose up -d
d-delete:
	docker-compose down


