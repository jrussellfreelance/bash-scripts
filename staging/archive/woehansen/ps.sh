#!/bin/bash
# Usage: sudo bash ps.sh 1 (for length of one minute)
# Set IFS to newline
IFS='
'
# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}
# Grab parameters ###TODO###
time=1
#fname=$2 || "$defaultfname"
# Calculate number of executions
exec_count=$((($time*60)/10))

# Create associative array
declare -A cpu_data
declare -A mem_data
declare -A ppid_data
declare -A cmd_data

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
#ppid_data[$PID] = "$PPD"
#cmd_data[$PID]  = "$CMD"
cpuprev = $(echo ${cpu_data[$PID]})
cpusum = $(bc -l <<< "$cpuprev + $CPU")
cpu_data[$PID] = $(echo $cpusum)
#mem_data[$PID] += $(($MEM))
#row="$counter,$PID,$PPD,$CMD,$MEM,$CPU"
#echo $row >> $defaultfname
done
# Increment counter
((counter++))
# Start ten second sleep
sleep 10
done

# Print results
for key in ${!cpu_data[@]}; do
    echo ${key} ${cpu_data[${key}]}
done

#ppid_data[$PID] = "$PPD"
#cmd_data[$PID]  = "$CMD"

#mem_data[$PID] += $(($MEM))
#row="$counter,$PID,$PPD,$CMD,$MEM,$CPU"
#echo $row >> $defaultfname