pad=$(printf '%0.1s' "."{1..23})
padlength=23
#  | sed -e 's/^[[:space:]]*//' | sed -e 's/://' | awk '{print $0}')
sys_output=$(/usr/bin/landscape-sysinfo | grep -v IPv4 | grep -v IPv6)
for row in $sys_output
do
  first_col=$(echo $row | awk '{print "   - " $1}')
  second_col=$(echo $row | awk '{print $2}')
  printf '%s' "$row"
  printf '%*.*s' 0 $((padlength - ${#first_col} - ${#second_col} )) "$pad"
  printf '%s\n' "$second_col"
done
separator="..............:"
for row in $(/usr/bin/landscape-sysinfo | grep -v IPv4 | grep -v IPv6 | sed -e 's/://' | sed 's/\s{3,\}/|/g')
do
  first_col=$(echo $row | awk '{print $1}')
  echo $row | awk '{print $1}'
  second_col=$(echo $row | awk '{print $2}')
  echo $row | awk '{print $2}'
  printf "   -  $first_col${separator:second_col}$second_col\n"
done