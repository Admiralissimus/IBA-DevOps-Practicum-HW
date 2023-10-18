# IBA-DevOps-Practicum-HW

## 1. Развернуть Jenkins.
> task1.sh нужно запустить с рут-правами на сервере для Jenkins

## 2. Создать Job, она должна уметь разворачивать ELK stack на другом slave любым способом. Если не хватает ресурсов, тогда развернуть только ELasticsearch.

> task1.sh is started at Jenkins-server

> task2.sh is started at node


job is added by jenkins cli: 

`java -jar jenkins-cli.jar -auth user:pass -s http://localhost:8080/ create-job job.xml`


