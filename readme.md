## Bash Scripts
This is a collection of bash scripts I've written to manage my servers.  I hope you can find them useful!  Scripts that are specific to Ubuntu are noted with "ubuntu-" in front of the filename.

Note: Several of the scripts use another file as a template for generating a new file, so they should stay with the script.  This applies to the following files:

* phpconfig and default.conf go with new-nginx-php
* reverseproxy goes with new-nginx-rp
* wpdns and default.conf goes with newwp-dns
* wpport and default.conf goes with newwp-port

Here is a brief description of each script:

git-pull-folders: Runs `git pull` on all folders inside a root folder.

linktobin: Links script to /usr/share/bin.

newdb-mongo: Creates a new MongoDB database and user.

newdb-mysql: Creates a new MySQL database and user.

restart-web: Restarts the nginx and php-fpm services.

setup-docker-compose.sh: Installs docker-compose on your server.

start-pm2-apps: Starts all Node.js apps inside a root folder.

sysinfo: Grabs system information, outputs it to a file, then sends an email.

ubuntu-loggy: A command line tool that quickly shows the contents of predefined log files.

ubuntu-new-nginx-php (with phpconfig): Generates a nginx config and php-fpm config based on the values you give it.

ubuntu-new-nginx-rp (with reverseproxy): Generates a nginx config for a reverse proxy set up, based on the values you give it.

ubuntu-new-systemd: Creates a systemctl service entry for the command you give it.

ubuntu-newwp-dns: Creates a new wordpress instance with a DNS entry / url.

ubuntu-newwp-port: Creates a new wordpress instance that runs on a port.

ubuntu-rmwp: Removes and deletes a wordpress instance.

ubuntu-setup-ajenti-server.sh: Installs Ajenti 1 on your server.

ubuntu-setup-docker.sh: Installs docker on your server.

ubuntu-setup-gcs-fuse.sh: Installs Google Cloud SDK and GCS Fuse on your server so you can mount bucket storage.

ubuntu-setup-lemp-server.sh: Installs the LEMP stack on your server.

ubuntu-setup-mongodb.sh: Installs MongoDB on your server.

ubuntu-setup-nodejs.sh: Installs Node.js and Nginx on your server.

watchnginx: Uses inotifywait to monitor the nginx folder for changes, and restarts nginx and php-fpm when a change occurs.

webmon: Checks to see whether a website is up or down, and sends an email if it is down.