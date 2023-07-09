#!/bin/bash
set -e
sudo apt update

echo "Installing java"
sudo apt -y install openjdk-17-jre
java -version


