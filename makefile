minikube_start:
	minikube start --driver=docker --container-runtime=containerd

minikube_stop:
	minikube stop

kubectl_apply: kompose
	kubectl apply -f frontend-deployment.yaml,frontend-service.yaml,message-api-deployment.yaml,message_api-service.yaml

kubectl_delete:
	kubectl delete -f frontend-deployment.yaml,frontend-service.yaml,message-api-deployment.yaml,message_api-service.yaml

dashboard:
	minikube dashboard

kompose:
	kompose convert