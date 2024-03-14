
# Builds the containers for the kubernetes cluster
build:
	bash kubernetes_build_containers.sh

deploy: build k-apply
delete: k-delete

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
d-deploy:
	docker-compose up -d
d-delete:
	docker-compose down


