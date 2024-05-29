# General kubernetes commands
authorize: k-auth
deploy: k-apply
undeploy: k-delete
remake: k-delete k-apply
nuke: k-delete deauthorize

deploy-l: pull d-deploy

# Kubectl context commands
contexts: k-context

use-netlab: k-set-context-netlab
use-azure: k-set-context-azure
use-minikube: k-set-context-minikube
use-docker-desktop: k-set-context-docker-desktop

# Kubectl list commands
pods:
	kubectl get pods
services:
	kubectl get services

k-context:
	kubectl config get-contexts
k-set-context-netlab:
	kubectl config use-context s-a-rb04-grp3
k-set-context-azure:
	kubectl config use-context PixelChat-Cluster
k-set-context-minikube:
	kubectl config use-context minikube
k-set-context-docker-desktop:
	kubectl config use-context docker-desktop

deauthorize:
	kubectl delete -f kubernetes/dockerconfigjson.yaml

pull:
	docker pull ghcr.io/teunmos-pixelchat/frontend:develop
	docker pull ghcr.io/teunmos-pixelchat/gateway:develop
	docker pull ghcr.io/teunmos-pixelchat/message-api:develop



# kubernetes deployment commands
k-apply:
	kubectl apply -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml,kubernetes/ingress.yaml,kubernetes/autoscaling.yaml,kubernetes/postgresDB.yaml,kubernetes/user-service.yaml,kubernetes/cassandraDB.yaml
k-delete:
	kubectl delete -f kubernetes/front-end.yaml,kubernetes/gateway.yaml,kubernetes/message-api.yaml,kubernetes/ingress.yaml,kubernetes/autoscaling.yaml,kubernetes/postgresDB.yaml,kubernetes/user-service.yaml,kubernetes/cassandraDB.yaml

k-apply-secret:
	kubectl apply -f kubernetes/dockerconfigjson.yaml




# # kubernetes volume commands
# k-apply-v:
# 	kubectl apply -f kubernetes/postgresVolume.yaml,kubernetes/cassandraVolume.yaml
# k-delete-v:
# 	kubectl delete -f kubernetes/postgresVolume.yaml,kubernetes/cassandraVolume.yaml



# use 1password cli to get docker secret
k-auth:
	cp kubernetes/dockerconfigjson.yaml kubernetes/dockerconfigjson.secret.yaml
	sed -i 's/\(.dockerconfigjson: \).*/\1$(shell op read op://personal/DockerKube/dockerconfigjson)/' kubernetes/dockerconfigjson.secret.yaml

	kubectl apply -f kubernetes/dockerconfigjson.secret.yaml

	cp kubernetes/secrets.yaml kubernetes/secrets.secret.yaml

	sed -i 's/\(POSTGRES_CONN_STRING: \).*/\1$(shell op read op://school/pixelchat-user-service-env/postgres_conn_string | base64 -w 0)/' kubernetes/secrets.secret.yaml
	sed -i 's/\(AUTH0_CLIENT_ID: \).*/\1$(shell op read op://school/pixelchat-user-service-env/auth0_client_id | base64 -w 0)/' kubernetes/secrets.secret.yaml
	sed -i 's/\(AUTH0_CLIENT_SECRET: \).*/\1$(shell op read op://school/pixelchat-user-service-env/auth0_client_secret | base64 -w 0)/' kubernetes/secrets.secret.yaml
	sed -i 's/\(AUTH0_DOMAIN: \).*/\1$(shell op read op://school/pixelchat-user-service-env/auth0_domain | base64 -w 0)/' kubernetes/secrets.secret.yaml

	kubectl apply -f kubernetes/secrets.secret.yaml

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
# mini-start:
# 	minikube start --driver=docker --container-runtime=containerd
# mini-stop:
# 	minikube stop
# mini-dashboard:
# 	minikube dashboard



# read the docker secret from 1password (CLI)
dockersecret:
	@op read op://personal/DockerKube/dockerconfigjson

cassandra-status:
	kubectl exec -it pixelchat-cassandra-0 -- nodetool status