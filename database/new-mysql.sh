#!/bin/bash
# Designed for Ubuntu 18.04
# This script creates a new MySQL database and database user.
echo A MySQL Database Creation Script
# Grab new database name, user, password, and root password.
while [[ -z "$NEWDB" ]]
do
    read -p "database name >> " NEWDB
done
while [[ -z "$NEWUSER" ]]
do
    read -p "database user >> " NEWUSER
done
while [[ -z "$NEWPWD" ]]
do
    read -s -p "database user pass >> " NEWPWD
done
while [[ -z "$ROOTPWD" ]]
do
    read -s -p "database root pass >> " ROOTPWD
done
# Create new database and user
mysql -uroot -p$ROOTPWD <<EOF 
CREATE DATABASE $NEWDB;
CREATE USER $NEWUSER@localhost IDENTIFIED BY "$NEWPWD";
GRANT ALL PRIVILEGES ON $NEWDB.* TO $NEWUSER@localhost IDENTIFIED BY '$NEWPWD';
FLUSH PRIVILEGES;
exit
EOF
