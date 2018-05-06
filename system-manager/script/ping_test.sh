#!/bin/bash
for ip in ` awk '{print $1} nodes'`        #nodes means the host you want to check 
do
  ping -c 1 $ip > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "$ip is Online" 
  else
    echo "$ip is Offline" 
  fi
done
