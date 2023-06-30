#!/bin/bash
# Deploy Asciinema on a server
git clone --recursive https://github.com/asciinema/asciinema-server.git
cd asciinema-server
git checkout master
git checkout -b underdog master
cp .env.production.sample .env.production
echo nano .env.production