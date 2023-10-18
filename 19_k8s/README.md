# IBA-DevOps-Practicum-HW

1.	Развернуть EKS кластер с помощью terraform, задеплоить mongodb используя подходящий тип поды.
terraform init
terraform plan
terraform apply
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
kubectl apply -f deployment.yml

https://devopscube.com/deploy-mongodb-kubernetes/
Create the Secret.
kubectl apply -f mongodb-secrets.yaml

Create MongoDB Persistent Volume (Claims)
kubectl create -f mongodb-pvc.yaml

Create deployment
kubectl apply -f mongodb-deployment.yaml

Let’s create a NodePort type service.
kubectl create -f mongodb-nodeport-svc.yaml

For tests create mongodb-client
kubectl create -f mongodb-client.yaml
kubectl exec deployment/mongo-client -it -- /bin/bash


2.	Подключить кластер к Lens.
+

