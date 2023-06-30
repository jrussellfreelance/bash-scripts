#!/bin/bash
# Designed for Ubuntu
# create-sudo-user - A script that creates a new sudo user

##### Functions

usage()
{
    echo "sudo bash new-dns.sh -n [name] -d [FQDN] -f [FPM port] -db [db name] -u [db user] -p [db pass] -r [MySQL root pass]"
}

##### Main
# Set variables
name=
domain=
fpmport=
dbname=
dbuser=
dbpass=
rootpwd=
phpver=
# Process arguments
while [ "$1" != "" ]; do
    case $1 in
        -n | --name )
            shift
            name=$1
            ;;
        -d | --domain )
            shift
            domain=$1
            ;;
        -f | --fpmport )
            shift
            fpmport=$1
            ;;
        -db | --database )
            shift
            dbname=$1
            ;;
        -u | --user )
            shift
            dbuser=$1
            ;;
        -p | --pass )
            shift
            dbpass=$1
            ;;
        -r | --root )
            shift
            rootpwd=$1
            ;;
        -v | --phpver )
            shift
            phpver=$1
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

mysql -uroot -p$rootpwd <<EOF
CREATE DATABASE $dbname;
CREATE USER $dbuser@localhost IDENTIFIED BY "$dbpass";
GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost IDENTIFIED BY "$dbpass";
FLUSH PRIVILEGES;
exit
EOF

cp ./wpdns /etc/nginx/sites-available/$name

ln -s /etc/nginx/sites-available/$name /etc/nginx/sites-enabled/$name

sed -i 's/sub.domain.ext/'$domain'/g' /etc/nginx/sites-available/$name
sed -i 's/900x/'$fpmport'/g' /etc/nginx/sites-available/$name
sed -i 's/site_files_here/'$name'/g' /etc/nginx/sites-available/$name

cp ./phpfpm.conf /etc/php/$phpver/fpm/pool.d/$name.conf

sed -i 's/pool_name_here/'$name'/g' /etc/php/$phpver/fpm/pool.d/$name.conf
sed -i 's/900x/'$fpmport'/g' /etc/php/$phpver/fpm/pool.d/$name.conf

wget http://wordpress.org/latest.tar.gz > /dev/null 2>&1

tar xfx latest.tar.gz
rm -f latest.tar.gz

mv wordpress /var/www/$name

touch /var/www/$name/php.ini

echo "upload_max_filesize = 128M" >> /var/www/$name/php.ini
echo "post_max_size = 128M" >> /var/www/$name/php.ini
echo "max_execution_time = 120" >> /var/www/$name/php.ini

chmod 644 /var/www/$name/php.ini

cp /var/www/$name/wp-config-sample.php /var/www/$name/wp-config.php

chown www-data:www-data /var/www/$name -R

sed -i 's/database_name_here/'$dbname'/g' /var/www/$name/wp-config.php
sed -i 's/username_here/'$dbuser'/g' /var/www/$name/wp-config.php
sed -i 's/password_here/'$dbpass'/g' /var/www/$name/wp-config.php

systemctl restart "php$phpver-fpm"
systemctl restart nginx

#certbot --nginx -d $domain

#echo "new-dns.sh -n $name -d $domain -f $fpmport -db $dbname -u $dbuser -p $dbpass"
