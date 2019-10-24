#!/bin/bash
# This script creates a new MongoDB database and database user
echo A MongoDB Database Creation Script
# Grab new database name, user, and password
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
# Create database and then user
mongo <<EOF
use $NEWDB
db.createUser( { user: $NEWUSER,
                 pwd: $NEWPWD,
                 roles: [ { role: "readWrite", db: $NEWDB } ]
             } )
exit
EOF