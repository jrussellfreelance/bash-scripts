#!/bin/bash
# This script creates a systemd entry for a custom command
echo "A systemd service creator"
while [[ -z "$APPNAME" ]]
do
read -p "App Name / Description (nospaces): " APPNAME
done
while [[ -z "$COMMAND" ]]
do
read -p "Startup command: " COMMAND
done
mkdir -p ~/scripts/startup
echo $COMMAND >> ~/scripts/startup/$APPNAME.sh
chmod 755 ~/scripts/startup/$APPNAME.sh
echo '[Unit]' >> /etc/systemd/system/$APPNAME.service
echo "Description=$APPNAME" >> /etc/systemd/system/$APPNAME.service
echo '[Service]' >> /etc/systemd/system/$APPNAME.service
echo "ExecStart=~/scripts/startup/$APPNAME.sh" >> /etc/systemd/system/$APPNAME.service
echo '[Install]' >> /etc/systemd/system/$APPNAME.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/$APPNAME.service
systemctl enable $APPNAME
systemctl start $APPNAME
systemctl status $APPNAME
echo "All done!"