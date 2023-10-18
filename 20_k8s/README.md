# IBA-DevOps-Practicum-HW

1.	Создать любую страничку на php.
index.php
```
<html>
<head>
<title>Page on PHP</title>
</head>
<body>
<h1>Example using PHP</h1>
<p>This page shows your current IP address and current server time.</p>
<p>Your IP address: <?php echo $_SERVER['REMOTE_ADDR']; ?></p>
<p>Current date and time: <?php echo date('d.m.Y H:i:s'); ?></p>
</body>
</html>
```
2.	Создать рабочий докер имадж для страницы с php.
Dockerfile
```
FROM php:apache
COPY index.php /var/www/html/
EXPOSE 80

```
docker build -t iba-20-hw:v1 .

docker run --rm -p 8080:80 iba-20-hw:v1 #for local test

docker tag iba-20-hw:v1 admiralissimus/iba-20-hw:v1

docker push admiralissimus/iba-20-hw:v1

3.	Развернуть deployment с php в eks.

terraform init

terraform plan

terraform apply

kubectl apply -f deployment.yml

4.	Сделать чтобы страничка с php была доступна извне. Использовать ingress.

kubectl apply -f https://projectcontour.io/quickstart/contour.yaml

kubectl apply -f deployment.yml 
> deployment.apps/php-deployment created

kubectl apply -f service-php-clusterip.yml 
> service/service-php-clusterip created

kubectl apply -f ingress.yaml 
> ingress.networking.k8s.io/php-ingress created


5.	Дать пользователю arn:aws:iam::097084951758:user/alex_b доступ в кластер.

added to main.tf file
