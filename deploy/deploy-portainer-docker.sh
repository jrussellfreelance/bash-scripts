#!/bin/bash
# Tested on Ubuntu 18.04
# This script deploys Portainer via docker
docker volume create portainer_data
docker run -d --name=portainer --restart=always \
 -p 8000:8000 -p 9000:9000 \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v portainer_data:/data \
 portainer/portainer
