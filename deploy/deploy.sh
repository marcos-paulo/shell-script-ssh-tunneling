#!/bin/bash
source "../env"
source "../print_log.sh"
source "../colors.sh"

tag_no_figlet "Starting Deploy"

warning() {
  red "One parameter is required in deploy.sh, which must be "
  yellow "main"
  red " or "
  yellow "develop\n"
  exit 1
}

match_regex() {
  match=$(echo "$1" | grep -P "$2")
  [[ -n $match ]] && $3 || $4
}

match_regex "$1" "^(main|develop)$" "" "warning"

date_log "DEPLOY" "Clean server" "$VERDE"

cat "./clean_server.sh" | ssh pi@$ip_local_server_to_deploy "/bin/bash"

date_log "DEPLOY" "Exporting environment variables" "$VERDE"

cat "../env" | ssh pi@$ip_local_server_to_deploy \
  "cat >> /home/pi/ssh_tunneling.app/env"

date_log "DEPLOY" "Installing post-receive script" "$VERDE"

install_post_receive() {
  cat "$1" | ssh pi@$ip_local_server_to_deploy \
    "cat >> /home/pi/ssh_tunneling.git/hooks/post-receive"

  ssh pi@$ip_local_server_to_deploy \
    "chmod +x /home/pi/ssh_tunneling.git/hooks/post-receive"
}

case "$1" in
"main") install_post_receive "./post-receive" ;;
"develop") install_post_receive "./post-receive-develop" ;;
esac

date_log "DEPLOY" "Running git push deploy $1" "$VERDE"

git push deploy $1

date_log "DEPLOY" "Start application" "$VERDE"

ssh pi@$ip_local_server_to_deploy \
  'cd /home/pi/ssh_tunneling.app && 
    ./main.sh && 
    sleep 1 && 
    tail -n 50 -f ./stdout*.txt'
