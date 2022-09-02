#!/bin/bash
source ./envs.sh

echo -- 0 Reiniciando o serviço -- >>saida.txt
# echo o pid é $! e $$ >>saida.txt

PID=$$
echo -- 1 -- >>saida.txt
ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" >>saida.txt
echo -- 2 -- >>saida.txt
ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" | awk '{print $2}' | grep -v $PID | xargs >>saida.txt
echo -- 3 -- >>saida.txt
ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" | awk '{print $2}' | grep -v $PID | xargs --no-run-if-empty kill -9 >>saida.txt
echo -- 4 -- >>saida.txt
ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" >>saida.txt
echo -- 5 -- >>saida.txt
while [ 1 ]; do
  nc -z $ip_remote_server $port_remote_server
  nc_return=$?
  if [ "$nc_return" -eq 0 ]; then
    echo $(date) : Conectado >>saida.txt
  else
    echo $(date) : Servidor desconectado, reconectando agora >>saida.txt
    pkill -9 -f "ssh -R" >>saida.txt
    ssh -R $port_remote_server:$ip_host_local:$port_host_local -N -f root@$ip_remote_server -p $port_ssh_server >>saida.txt
  fi
  sleep $time_sleep >>saida.txt
done
