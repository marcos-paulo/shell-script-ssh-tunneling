#!/bin/bash
source "./colors.sh"
source "./print_log.sh"
source "./ansi-functions.sh"

if [ -e "./env" ]; then
  source ./env
else
  echo ".env: No such file"
  exit 1
fi

PID=$$

list_services() {
  tag_no_figlet "${1:-"Checking active services - Current PID: $PID"}"
  ps aux | grep -v grep | grep --perl-regexp "ssh -o|ssh -R|ssh_t" | awk '{print" "$2"\t"$11,$12,$13,$14,$15,$16,$17,$18;}'
}

list_services_to_be_finished() {
  tag_no_figlet "List services to be finished"
  ps aux | grep -v grep | grep --perl-regexp "ssh -o|ssh -R|ssh_t" | awk '{print" "$2"\t"$11,$12,$13,$14,$15,$16,$17,$18;}' | grep -v $PID
}

terminate_old_services() {
  ps aux | grep -v grep | grep --perl-regexp "ssh -o|ssh -R|ssh_t" | awk '{print $2}' | grep -v $PID | xargs --no-run-if-empty kill -9
}

terminate_ssh_connection() {
  pkill -9 -f "ssh -R"
}

testing_connection() {
  nc_return=$(nc -vz $ip_remote_server $port_remote_server 2>&1)
}

new_ssh_connection() {
  ssh_return=$(ssh -o ConnectTimeout=$connect_ssh_timeout -R $port_remote_server:$ip_host_local:$port_host_local -N -f root@$ip_remote_server -p $port_ssh_server 2>&1)
}

loadding() {
  array=("|" "/" "-" "\\")
  i=0

  PRINT="\033[1D OK\n"
  while [[ "$nc_return" =~ .*(failed: Connection refused)$ ]]; do
    sleep 0.2
    testing_connection
    printf "\033[1D${array[$i]}"
    if [ $i -lt 3 ]; then
      i=$(($i + 1))
    else
      i=0
    fi
  done
  printf "$PRINT"
}

start_service() {
  tag_no_figlet "Initializing connection!"
  while [ 1 ]; do
    date_log "Server" "Check connection!" "$AMARELO"
    testing_connection

    if [[ "$nc_return" =~ .*( succeeded!)$ ]]; then
      date_log "Server" "$nc_return" "$VERDE"
      sleep $time_for_waiting

    else
      date_log "Server" "$nc_return" "$VERMELHO"

      date_log "Server" "Terminate ssh service connections" "$VERMELHO" "$AMARELO"
      terminate_ssh_connection

      date_log "Server" "Establishing new ssh service connection" "$VERMELHO" "$AMARELO"
      new_ssh_connection

      if [ -n "$ssh_return" ]; then
        date_log "Server" "$ssh_return" "$VERMELHO"
      else
        date_log "Server" "Waiting for connection...  " "$VERMELHO" "$AMARELO" "nom-break"
        loadding
      fi
    fi

  done
}

list_services
list_services_to_be_finished
terminate_old_services

if [ "$1" != "stop" ]; then
  start_service
fi
