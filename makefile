minikube_start:
	minikube start --driver=docker --container-runtime=containerd

minikube_stop:
	minikube stop

kubectl_apply:
	kubectl apply -f frontend-deployment.yaml,frontend-service.yaml,message_api-deployment.yaml,message_api-service.yaml,backend-deployment.yaml

kubectl_delete:
	kubectl delete -f frontend-deployment.yaml,frontend-service.yaml,message_api-deployment.yaml,message_api-service.yaml,backend-deployment.yaml

dashboard:
	minikube dashboard

kompose:
	kompose convert