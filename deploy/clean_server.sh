#!/bin/bash

cd /home/pi/ssh_tunneling.app/

[ -e "./main.sh" ] && echo Stopping service!!
[ -e "./main.sh" ] && ./main.sh stop

sleep 2

rm -rf /home/pi/ssh_tunneling.git/*

rm -rf /home/pi/ssh_tunneling.app/*

cd /home/pi/ssh_tunneling.git/

git init --bare
