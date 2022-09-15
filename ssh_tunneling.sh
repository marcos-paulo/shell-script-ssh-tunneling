#!/bin/bash
source "./colors.sh"

if [ -e "./env" ]; then
  source ./env
else
  echo ".env: No such file"
  exit 1
fi

printf "" >>saida.txt
echo >>saida.txt
# echo o pid é $! e $$ >>saida.txt

PID=$$

list_services() {
  echo -- ${1:-"Checking active services"} -- >>saida.txt
  ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" >>saida.txt
  echo >>saida.txt
}

list_services_to_be_finished() {
  echo -- List services to be finished -- >>saida.txt
  ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" | awk '{print $2}' | grep -v $PID | xargs >>saida.txt
  echo >>saida.txt
}

terminate_services() {
  echo -- Terminate services -- >>saida.txt
  ps aux | grep -v grep | grep --perl-regexp "ssh -R|ssh_t" | awk '{print $2}' | grep -v $PID | xargs --no-run-if-empty kill -9 2>&1 >>saida.txt
  echo >>saida.txt
}

start_service() {
  echo -- Connecting server -- >>saida.txt
  ssh -R $port_remote_server:$ip_host_local:$port_host_local -N -f root@$ip_remote_server -p $port_ssh_server >>saida.txt
  echo >>saida.txt
}

start() {
  while [ 1 ]; do
    echo -- Check connection! -- >>saida.txt
    sleep 5
    nc -vz $ip_remote_server $port_remote_server >>saida.txt 2>&1
    nc_return=$?
    if [ "$nc_return" -eq 0 ]; then
      echo $(date) : Connected server >>saida.txt
      sleep $time_sleep >>saida.txt
    else
      echo $(date) : Disconnected server, reconnecting now >>saida.txt
      terminate_services
      start_service
      list_services "List service post connection!"
    fi
  done
}

list_services
list_services_to_be_finished
terminate_services
list_services
start
