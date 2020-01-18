#!/bin/bash
add-apt-repository ppa:certbot/certbot
apt update
apt install -y certbot python-certbot-nginx
