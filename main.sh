#!/bin/bash
OUTPUT="stdout_$(date +%Y%m%d%H%M%S).txt"
mv ./*.txt ./log/
mkdir -p log
./ssh_tunneling.sh "$1" >$OUTPUT &
