#!/bin/bash
source "../env"
source "../print_log.sh"
source "../colors.sh"

warning() {
  branchs=$(git branch | sed -E "s/\*| //g")
  red "One parameter is required in deploy.sh, which can be ("
  for b in $branchs; do
    yellow "$b"
    red ", "
  done
  red "\033[2D)!\n"
  exit 1
}

match_branch() {
  branch_name=$(git branch | sed -E "s/\*| //g" | grep -P "^$1$")
  [[ -n $branch_name ]] && $2 || $3
}

match_branch "$1" "" "warning"

tag_no_figlet "Starting deploy in branch $branch_name"

date_log "DEPLOY" "Clean server" "$VERDE"

cat "./clean_server.sh" | ssh pi@$ip_local_server_to_deploy "/bin/bash"

date_log "DEPLOY" "Exporting environment variables" "$VERDE"

cat "../env" | ssh pi@$ip_local_server_to_deploy \
  "cat >> /home/pi/ssh_tunneling.app/env"

date_log "DEPLOY" "Installing post-receive script" "$VERDE"

install_post_receive() {
  cat "./post-receive" | sed -E "s/branch_name/$branch_name/g" | ssh pi@$ip_local_server_to_deploy \
    'cat >>/home/pi/ssh_tunneling.git/hooks/post-receive &&
      chmod +x /home/pi/ssh_tunneling.git/hooks/post-receive'
}

install_post_receive

date_log "DEPLOY" "Running git push deploy $1" "$VERDE"

git push deploy $1

date_log "DEPLOY" "Start application" "$VERDE"

ssh pi@$ip_local_server_to_deploy \
  'cd /home/pi/ssh_tunneling.app && ./main.sh'

sleep 2

ssh pi@$ip_local_server_to_deploy \
  'cd /home/pi/ssh_tunneling.app && tail -n 50 -f ./stdout*.txt'
