#!/bin/bash

tag_figlet() {
  FIGLET="$NEGRITO"
  FIGLET+="$VERDE"
  FIGLET+="\n"
  FIGLET+="$(figlet -f big "$1")"
  FIGLET+="$NORMAL\n"

  printf "$FIGLET"
}

tag_no_figlet() {
  TAG_NO_FIGLET=
  TAG_NO_FIGLET="\n${3:-$AZUL}"
  TAG_NO_FIGLET+="####################################################################################################"
  TAG_NO_FIGLET+="${NORMAL}\n"
  TAG_NO_FIGLET+="${3:-$AZUL}${2}${NORMAL} ${4:-${3:-$VERDE}}${1}${NORMAL}\n"
  TAG_NO_FIGLET+="${3:-$AZUL}"
  TAG_NO_FIGLET+="####################################################################################################"
  TAG_NO_FIGLET+="${NORMAL}\n"
  printf "$TAG_NO_FIGLET"
}

tag_no_figlet_without_#() {
  TAG_NO_FIGLET=
  TAG_NO_FIGLET+="${3:-$AZUL}${1}${NORMAL} ${4:-${3:-$VERDE}}${2}${NORMAL}$5"
  printf "$TAG_NO_FIGLET"
}

date_log() {
  break="\n"
  if [ "$5" = "nom-break" ]; then
    break=
  fi
  tag_no_figlet_without_# "${1:+[$1][$(date)]}" "$2" "$3" "$4" "$break"
}
