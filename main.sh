#!/bin/bash
OUTPUT="stdout_$(date +%Y%m%d%H%M%S).txt"
quantity_log=$(ls -a | grep ".txt" | wc -w)
mkdir -p log
if [ $quantity_log -gt 0 ]; then
  mv ./*.txt ./log/
fi
./ssh_tunneling.sh "$1" >$OUTPUT &
