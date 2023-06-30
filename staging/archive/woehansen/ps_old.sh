#!/bin/bash
# Usage: sudo bash ps.sh 1 (for length of one minute)
# Set IFS to newline
IFS='
'
# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}
# Write header to CSV
HEADERS='IID,PID,PPID,CMD,MEM,CPU'
defaultfname="topten$(timestamp).csv"
echo $HEADERS >> "$defaultfname"
# Grab parameters ###TODO###
time=2
#fname=$2 || "$defaultfname"
# Calculate number of executions
exec_count=$((($time*60)/10))

# Begin loop
counter=0
while [ $counter -le $exec_count ]
do
# Execute ps command and iterate over rows individually
for r in `ps -Ao pid,ppid,comm,%mem,%cpu --sort=-%cpu | head | tail -n +2 | awk ' {print $1,$2,$3,$4,$5 }'`;
do
# Store data into variables and write to CSV
PID="$(echo $r | cut -d' ' -f1)"
PPD="$(echo $r | cut -d' ' -f2)"
CMD="$(echo $r | cut -d' ' -f3)"
MEM="$(echo $r | cut -d' ' -f4)"
CPU="$(echo $r | cut -d' ' -f5)"
row="$counter,$PID,$PPD,$CMD,$MEM,$CPU"
echo $row >> $defaultfname
done
# Increment counter
((counter++))
# Start ten second sleep
sleep 10
done
