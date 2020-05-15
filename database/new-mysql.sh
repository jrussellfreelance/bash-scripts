#!/bin/bash
# Designed for Ubuntu 18.04
# This script creates a new MySQL database and database user.
echo A MySQL Database Creation Script
# Grab new database name, user, password, and root password.
while [[ -z "$NEWDB" ]]
do
    read -p "New database name: " NEWDB
done
while [[ -z "$NEWUSER" ]]
do
    read -p "New database user: " NEWUSER
done
while [[ -z "$NEWPWD" ]]
do
    read -s -p "New database user's password: " NEWPWD
done
while [[ -z "$ROOTPWD" ]]
do
    read -s -p "MySQL root password: " ROOTPWD
done
# Create new database and user
mysql -uroot -p$ROOTPWD <<EOF 
CREATE DATABASE $NEWDB;
CREATE USER $NEWUSER@localhost IDENTIFIED BY "$NEWPWD";
GRANT ALL PRIVILEGES ON $NEWDB.* TO $NEWUSER@localhost IDENTIFIED BY '$NEWPWD';
FLUSH PRIVILEGES;
exit
EOF
