#!/bin/bash
cd openmappr
docker-compose down && docker rmi $(docker images -a -q)
cd ../ && rm -rf openmappr
docker system prune
git clone https://github.com/selfhostedofficial/openmappr; cd openmappr
docker-compose -f docker-compose.do_staging.yml up -d