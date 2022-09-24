#!/bin/bash
export ssh_tunneling_path=$(echo $0 | sed 's/main.sh//g')

OUTPUT="stdout_$(date +%Y%m%d%H%M%S).txt"
quantity_log=$(ls -a ${ssh_tunneling_path} | grep ".txt" | wc -w)
mkdir -p ${ssh_tunneling_path}log
if [ $quantity_log -gt 0 ]; then
  mv ${ssh_tunneling_path}*.txt ${ssh_tunneling_path}log/
fi

${ssh_tunneling_path}ssh_tunneling.sh "$1" >${ssh_tunneling_path}${OUTPUT} 2>&1 &
