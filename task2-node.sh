#!/bin/bash
set -e
sudo apt update

echo "Installing java"
sudo apt -y install openjdk-17-jre
java -version

echo "Creating unprev user 'jenkins'"
sudo useradd -m -s /bin/bash jenkins

su jenkins
mkdir -p ~/.ssh
echo "$JENKINS_SERVER_SSH_KEY_PUB" >> ~/.ssh/authorized_keys
exit

echo "installing docker"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker jenkins

sudo sysctl -w vm.max_map_count=262144
#Чтобы сохранить это значение постоянно, обновите параметр vm.max_map_count в файле /etc/sysctl.conf. Чтобы проверить после перезагрузки, выполните команду sysctl vm.max_map_count.
