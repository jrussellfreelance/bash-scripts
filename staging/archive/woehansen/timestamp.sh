#!/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

# do something...
timestamp # print timestamp
# do something else...
timestamp # print another timestamp
# continue...

# ##################### #
# declare -A data ##### #
# data[$PID"-CPU"]=$CPU #
# data[$PID"-MEM"]=$MEM #
# data[$PID"-CMD"]=$CMD #
# ##################### #


for key in ${!data[@]}; do
    echo ${key} ${data[${key}]}
done