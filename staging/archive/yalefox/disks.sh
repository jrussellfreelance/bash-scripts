#!/bin/zsh
declare -A diskdata
diskutil list | grep /dev/disk | grep -E 'synthesized|external' | awk '{print $1}' | while read -r line ; do
    diskid=${line: -1}
    identifier=$(echo $line | cut -c 6-)"s1"
    diskname=$(diskutil list | grep $identifier | awk '{print $4}')
    if [[ diskname!="Macintosh"]]; then
    diskdata[$diskid]="$diskname"
    fi
done
for d in "${!diskdata[@]}" ; do
    echo "["$d"] "${diskdata[$d]}
done