#!/bin/bash
# tested on Ubuntu
# this script installs docker

# install dependencies
sudo apt install -y ca-certificates curl uidmap

# install docker using script
curl -sSL https://get.docker.com | sudo bash

# configure rootless docker
dockerd-rootless-setuptool.sh install