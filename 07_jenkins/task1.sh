#!/bin/bash
set -e
apt update

echo "Installing java"
apt -y install openjdk-17-jre
java -version

echo "Installing "
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get -y install jenkins

echo 'Export key to var $JENKINS_SERVER_SSH_KEY_PUB in nodes'

