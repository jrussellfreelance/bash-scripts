#!/bin/bash
# Designed for Ubuntu
# install-docker.sh - Installs docker and docker-compose
### Docker & docker-compose
apt remove remove docker docker-engine docker.io containerd runc
apt  install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common git -y   
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88    
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update
apt install docker-ce docker-ce-cli containerd.io -y
systemctl start docker              
systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose