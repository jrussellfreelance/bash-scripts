#!/bin/bash
for f in /home/sysadm6/scripts/*
do
	if cat $f | grep -q "#!/bin/bash"; then
		echo $f >> bashscripts.txt
	fi
done