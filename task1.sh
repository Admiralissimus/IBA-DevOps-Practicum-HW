#!/bin/bash
set -e

CONTAINER_NAME="docker-nginx"

docker run --name "$CONTAINER_NAME" -p 8080:80 -v ./html_src:/usr/share/nginx/html:ro -d nginx
sleep 5
echo
echo "-----------------------------"
echo
curl localhost:8080
echo
echo "-----------------------------"
echo
echo -n "All OK!!! Do you want to remove working container? (y/n): "
read -n1 answer
if [[ "$answer" =~ [yY] ]]; then
    docker rm -f "$CONTAINER_NAME"
    echo "Container was removed."
fi
echo