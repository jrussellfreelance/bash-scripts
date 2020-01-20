#!/bin/bash
# This script links a file to the /usr/share/bin folder, and is designed to be used like so:
# linktobin /home/user/script
if [ $# -eq 0 ]
then
	echo "Please specify the path for the link to /usr/share/bin"
else
	ln -s $1 /usr/share/bin
fi