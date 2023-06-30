#!/bin/bash
# Install MySQL Server
apt install mysql-server -y
systemctl start mysql
systemctl enable mysql
PASSWORD=$(openssl rand -base64 12)
mysql_secure_installation<<EOF
n
$PASSWORD
$PASSWORD
y
y
y
y
EOF
# Install PHP 7.2 and addons
apt install lsphp72 lsphp72-curl lsphp72-imap lsphp72-mysql lsphp72-intl lsphp72-pgsql lsphp72-sqlite3 lsphp72-tidy lsphp72-snmp -y