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

