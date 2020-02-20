#!/bin/bash
# Designed for Ubuntu
# init-project.sh - A script that creates a new git project

##### Functions

usage()
{
    echo 'bash init-project.sh -d "/path/to/project" -o "https://github.com/JacFearsome/bash-scripts.git"'
}

##### Main

dir=
origin=

while [ "$1" != "" ]; do
    case $1 in
        -d | --dir )            shift
                                dir=$1
                                ;;
        -o | --origin )         shift
                                origin=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
if [[ -z "$dir" || -z "$origin" ]]; then
	usage
else
cd $dir
git init
git add .
git commit -am "update"
git remote add origin $origin
git push -u origin master
fi