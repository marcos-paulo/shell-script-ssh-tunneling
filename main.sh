#!/bin/bash
OUTPUT="stdout_$(date +%Y%m%d%H%M%S).txt"
quantity_log=$(ls -a | grep ".txt" | wc -w)
if [ $quantity_log -gt 0 ]; then
  mv ./*.txt ./log/
fi
mkdir -p log
./ssh_tunneling.sh "$1" >$OUTPUT &
