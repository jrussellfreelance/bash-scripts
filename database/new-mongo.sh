#!/usr/bin/env bash
set -euo pipefail

# Designed for Ubuntu 18.04
# This script creates a new MongoDB database and database user.
newdb=
newuser=
newpwd=
echo A MongoDB Database Creation Script
# Grab new database name, user, and password
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
# Create database and then user
mongo <<EOF
use $NEWDB
db.createUser( { user: '$NEWUSER',
                 pwd: '$NEWPWD',
                 roles: [ { role: 'readWrite', db: '$NEWDB' } ]
             } )
exit
EOF
