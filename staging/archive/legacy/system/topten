#!/bin/bash
# This script runs for the specified amount of minutes, and calculates the top ten processes by resource usage.
# At the end it outputs two CSV files, sorted by memory and cpu usage.
# Set IFS to newline
IFS='
'
# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}
if [ -z "$1" ]
then
    echo "FATAL: Please enter the number of minutes"
    echo "Example: sudo bash topten.sh 15"
else
    # Grab parameters ###TODO###
    time=$1
    #fname=$2 || "$defaultfname"
    # Write header to CSV
    CPU_HEADERS='PID,CPU,MEM,CMD,PPID'
    cpu_fname="topten-cpu-$time-$(timestamp).csv"
    echo $CPU_HEADERS >> "$cpu_fname"
    MEM_HEADERS='PID,MEM,CPU,CMD,PPID'
    mem_fname="topten-mem-$time-$(timestamp).csv"
    echo $MEM_HEADERS >> "$mem_fname"
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
    # Store values from each row
    PID="$(echo $r | cut -d' ' -f1)"
    PPD="$(echo $r | cut -d' ' -f2)"
    CMD="$(echo $r | cut -d' ' -f3)"
    MEM="$(echo $r | cut -d' ' -f4)"
    CPU="$(echo $r | cut -d' ' -f5)"
    # Dynamically add data to associative arrays
    # CPU
    if [ -z "${cpu_data[$PID]}" ]
    then
        cpu_data[$PID]="$CPU"
    else
        cpuprev="$( echo ${cpu_data[$PID]} )"
        cpusum=$( echo "$cpuprev + $CPU" | bc -l)
        cpu_data[$PID]="$cpusum"
    fi
    # MEM
    if [ -z "${mem_data[$PID]}" ]
    then
        mem_data[$PID]="$MEM"
    else
        memprev="$( echo ${mem_data[$PID]} )"
        memsum=$( echo "$memprev + $MEM" | bc -l)
        mem_data[$PID]="$memsum"
    fi
    # PPID
    if [ -z "${ppid_data[$PID]}" ]
    then
        ppid_data[$PID]="$PPD"
    fi
    # CMD
    if [ -z "${cmd_data[$PID]}" ]
    then
        cmd_data[$PID]="$CMD"
    fi
    # End
    done
    # Increment counter
    ((counter++))
    # Start ten second sleep
    sleep 10
    done

    # Sort arrays and output
    # CPU
    for p in "${!cpu_data[@]}"
    do
        echo $p','${cpu_data["$p"]}','${mem_data["$p"]}','${cmd_data["$p"]}','${ppid_data["$p"]}
    done |
    sort -k2 -rn -t, >> "$cpu_fname"
    # MEM
    for p in "${!mem_data[@]}"
    do
        echo $p','${mem_data["$p"]}','${cpu_data["$p"]}','${cmd_data["$p"]}','${ppid_data["$p"]}
    done |
    sort -k2 -rn -t, >> "$mem_fname"
fi