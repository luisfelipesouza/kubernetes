# Change from GCP to Docker Desktop
kubectl config view
kubectl config current-context
kubectl config use-context docker-desktop

# View all pods
kubectl get pods

# Create new pod
kubectl run NAME --image=IMAGE
kubectl run nginx-pod --image=nginx:latest

kubectl get pods
kubectl get pods --watch
kubectl describe pod nginx-pod

# Edit pod (change image from latest to 1.0)
kubectl edit pod nginx-pod

#delete pod
kubectl delete pod nginx-pod

# got error "ErrImagePull" from prior action 
NAME        READY   STATUS         RESTARTS      AGE
nginx-pod   0/1     ErrImagePull   0 (45s ago)   4m50s

# Create Pod Declarativo
kubectl apply -f .\primeiro-pod.yaml
kubectl delete -f .\primeiro-pod.yaml

# Executar comando modo iterativo
kubectl exec -it portal-noticias -- bash

# Portal de noticiais
kubectl get pods -o wide

# SVC (Service) Abstração que expoe as aplicações
# prove IP fixo dos serviços & DNS & Loadbalancer
# POD <-> SVC <-> POD

# types: ClusterIP, NodePort, LoadBalancer
# SVC (Service) ClusterIP
kubectl get services
kubectl apply -f .\svc-pod-2.yaml
kubectl exec -it portal-noticias -- bash
> curl IP_SVC:9000

# SVC (Service) NodePort
kubectl apply -f .\svc-pod-1.yaml # create nodeport
kubectl apply -f .\pod-1.yaml # update labels
kubectl get nodes -o wide # get node internal IP

# Complete Solution
kubectl delete pods --all
kubectl delete svc --all

kubectl exec -it db-noticias -- bash
mysql -u root -p
show databases;
use empresa;
show tables;
select * from usuario;

# Extract env to ConfiMap
kubectl apply -f .\db-configmap.yaml
kubectl describe configmap db-configmap

# Replicaset
kubectl get replicasets
kubectl get rs --watch

# Deployment
kubectl get deployment
kubectl rollout history deployment nginx-deployment
kubectl apply -f .\nginx-deployment.yaml --record
kubectl annotate deployment nginx-deployment kubernetes.io/change-cause="Atualizado para versao latest"

# Deployment rollback
kubectl rollout history deployment nginx-deployment
kubectl rollout undo deployment nginx-deployment --to-revision=2

# Delete via file
kubectl delete -f .\portal-noticias-replicaset.yaml

# Pod com 2 container
kubectl exec -it pod-volume --container nginx-container -- bash
> cd volume-container
> touch arquivo.txt
kubectl exec -it pod-volume --container jenkins-container -- bash