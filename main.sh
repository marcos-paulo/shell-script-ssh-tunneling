#!/bin/bash
OUTPUT="stdout_$(date | sed -r "s/:|-| /_/g").txt"
mkdir -p log
./ssh_tunneling.sh "$1" >log/$OUTPUT
