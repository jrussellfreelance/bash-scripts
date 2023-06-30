#!/bin/bash
# This script links a file to the /usr/share/bin folder, and is designed to be used like so:
# linktobin.sh /home/user/script scriptname
if [ $# -lt 2 ]
then
	echo "Please specify the path for the link to /usr/bin"
else
	ln -s $1 /usr/bin/$2
fi