# Create associative array
declare -A cpu_data
declare -A mem_data

# Parse CSV data
# First WhileLoop Start
while read p; do
pIID="$(echo $p | cut -d',' -f1)"
pPID="$(echo $p | cut -d',' -f2)"
pPPD="$(echo $p | cut -d',' -f3)"
pCMD="$(echo $p | cut -d',' -f4)"
pMEM="$(echo $p | cut -d',' -f5)"
pCPU="$(echo $p | cut -d',' -f6)"
cpu_data[$pPID]=$pCPU
mem_data[$pPID]=$pMEM
# Second WhileLoop Start
while read q; do
qIID="$(echo $q | cut -d',' -f1)"
qPID="$(echo $q | cut -d',' -f2)"
qPPD="$(echo $q | cut -d',' -f3)"
qCMD="$(echo $q | cut -d',' -f4)"
qMEM="$(echo $q | cut -d',' -f5)"
qCPU="$(echo $q | cut -d',' -f6)"
# Conditional summing
if [ $pIID != $qIID ] && [ $pPID = $qPID ]
then
    cpu_data[$pPID]=$((cpu_data[$pPID]+$qCPU))
    mem_data[$pPID]=$((mem_data[$pPID]+$qMEM))
fi
# Second WhileLoop End
done <"$defaultfname"
# First WhileLoop End
done <"$defaultfname"

# Print results
for key in ${!cpu_data[@]}; do
    echo ${key} ${cpu_data[${key}]}
done
for key in ${!mem_data[@]}; do
    echo ${key} ${mem_data[${key}]}
done

# Write header to CSV
HEADERS='IID,PID,PPID,CMD,MEM,CPU'
defaultfname="topten$(timestamp).csv"
echo $HEADERS >> "$defaultfname"

###########################################


# Print results
echo "CPU:"
echo "--------"
for key in ${!cpu_data[@]}; do
    echo ${key} ${cpu_data[${key}]}
done
echo "--------"
echo "MEM:"
echo "--------"
for key in ${!mem_data[@]}; do
    echo ${key} ${mem_data[${key}]}
done
echo "--------"
echo "PPID:"
echo "--------"
for key in ${!ppid_data[@]}; do
    echo ${key} ${ppid_data[${key}]}
done
echo "--------"
echo "CMD:"
echo "--------"
for key in ${!cmd_data[@]}; do
    echo ${key} ${cmd_data[${key}]}
done
echo "--------"

echo "CPU:"
echo "--------"
echo ${cpu_data[*]}
echo "--------"
echo "MEM:"
echo "--------"
echo ${mem_data[*]}
echo "--------"
echo "PPID:"
echo "--------"
echo ${ppid_data[*]}
echo "--------"
echo "CMD:"
echo "--------"
echo ${cmd_data[*]}
echo "--------"