#!/bin/bash
OUTPUT="stdout_$(date +%Y%m%d%H%M%S).txt"
mkdir -p log
./ssh_tunneling.sh "$1" >log/$OUTPUT &
