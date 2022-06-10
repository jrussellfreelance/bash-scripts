#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script creates a new sudo user via script arguments.

##### Functions

usage()
{
    echo "sudo bash create-sudo-user-auto.sh -u user -p1 password -p2 password"
}

##### Main

name=
pass1=
pass2=

while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                name=$1
                                ;;
        -p1 | --pass1 )         shift
                                pass1=$1
                                ;;
        -p2 | --pass2 )         shift
                                pass2=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
if [[ -z "$name" || -z "$pass1" || -z "$pass2"  ]]; then
	usage
else
sudo useradd -s /bin/bash -d /home/$name/ -m -G sudo $name
sudo passwd $name <<EOF
$pass1
$pass2
EOF
fi
