#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script deploys mailcow through docker
git clone https://github.com/mailcow/mailcow-dockerized
cd mailcow-dockerized
./generate_config.sh
docker-compose up -d
