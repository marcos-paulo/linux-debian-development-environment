#!/bin/bash

write_log() {
  msg="$1"
  echo "$msg" >>install-workstation-log.txt
  echo "$msg"
}

# title() {
#
tag_figlet() {
  printf "$NEGRITO"
  printf "$VERDE"
  figlet "$1"
  printf "$NORMAL"
}

# $1 text of tag
# $2 label between bracket
# tag() {
tag_no_figlet() {
  printf "${AZUL}"
  printf "####################################################################################################"
  printf "${NORMAL}\n"
  printf "${AZUL}${2}${NORMAL} ${VERDE}${1}${NORMAL}\n"
  printf "${AZUL}"
  printf "####################################################################################################"
  printf "${NORMAL}"
}

# TODO BUG erase line from #### when pressing y
tag_question() {
  tag_no_figlet
  up_line
  return_car
  $1 "$2" "$3" "$4"
}
