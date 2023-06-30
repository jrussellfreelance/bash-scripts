#!/bin/bash
let i=0
while read line; do
  read fs size used avail usepct mounted <<<"$line"
  if [ "$fs" != Filesystem ]; then # skip header line
    printf "%s|" "$fs" "$size" "$used" "$avail" "$usepct" "$mounted"
    printf "\n"
  fi
done < <(df -H)