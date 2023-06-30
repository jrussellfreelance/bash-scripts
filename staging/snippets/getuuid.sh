# get uuid
uuid = blkid | grep $MOUNT | awk '{print $3}'
uuid=${uuid:5}
uuid=${uuid::-1}