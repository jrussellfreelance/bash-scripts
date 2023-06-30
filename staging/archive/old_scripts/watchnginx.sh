while true #run indefinitely
do
inotifywait -r -e modify,attrib,close_write,move,create,delete /etc/nginx && /bin/bash /usr/bin/restartNginxPhp.sh
done
