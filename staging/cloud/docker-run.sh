# Nextcloud
docker run -d --name nextcloud -p 8081:80 nextcloud
# doc-deploy-old
docker build -t ddserver .
docker build -t ddclient .
docker run -d --name server -p 8083:8080 ddserver
docker run -d --name client -p 8084:80 ddclient
# code-server
docker run -d --name coder -p 8084:8080 -v "$PWD:/home/coder/project" -u "$(id -u):$(id -g)" codercom/code-server:latest
docker run -d --name coder -p 8083:8080 -v "/home/jesse/dangora:/home/coder/project" -u "$(id -u):$(id -g)" -e PASSWORD=PowershellKungfu codercom/code-server:latest
ver:latest
#theia-ide
docker run -d --name theia theia --init -p 8082:3000 -v "$(PWD):/home/project:cached" theiaide/theia
# organizr
docker run -d --name organizr organizr:/config -e PGID=$(id -u) -e PUID=$(id -g)  -p 8085:80 organizrtools/organizr-v2
# portainer
docker volume create portainer_data && docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
# shaarli
docker volume create shaarli-data
docker volume create shaarli-cache
docker create \
    --name shaarli \
    -v shaarli-cache:/var/www/shaarli/cache \
    -v shaarli-data:/var/www/shaarli/data \
    -p 8086:80 \
    shaarli/shaarli:master
docker start shaarli
# ifm
docker run --rm -d --name ifm -p 8087:80 -e IFM_DOCKER_UID=1000 -e IFM_DOCKER_GID=100 -v /home/jesse:/var/www ifm:latest
# DashMachine
docker create \
  --name=dashmachine \
  -p 5000:5000 \
  -v dashmachine:/dashmachine/dashmachine/user_data \
  --restart unless-stopped \
  rmountjoy/dashmachine:latest
# shiori
docker run -d --name shiori -p 8085:8080 radhifadlillah/shiori
