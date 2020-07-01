# Deploy Scripts
### Deploy Shaarli to Docker
> Tested on Ubuntu 18.04

This script deploys Shaarli via docker.

It will ask you for which port to use.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/deploy-shaarli-docker)
```
### Deploy Nextcloud to Docker
> Tested on Ubuntu 18.04

This script deploys Nextcloud via docker.
It will ask you for which port to use, the domain name, and MySQL passwords.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/deploy-nextcloud-docker)
```
### Deploy WordPress to Docker
> Tested on Ubuntu 18.04

This script deploys Wordpress via docker.

It will ask you for which port to use, the domain name, and MySQL passwords.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/deploy-wordpress-docker)
```
### Deploy WordPress with OpenLiteSpeed
> Tested on Ubuntu 18.04

This script deploys WordPress and connfigures OpenLiteSpeed as the server.

It will prompt you for the domain, and will display the login information after it completes.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/deploy-wordpress-ols)
```