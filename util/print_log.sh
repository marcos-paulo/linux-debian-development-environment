#!/bin/bash
PATH_FILE_LOG="$path_sh/log/install-workstation-log.txt"
echo "" >$PATH_FILE_LOG

write_log() {
  # Read from positional argument $1
  if test -n "$1"; then
    echo "$1" >>"$PATH_FILE_LOG"
    echo "$1"

  # Read from stdin if file descriptor /dev/stdin is open
  elif test ! -t 0; then
    while read line; do
      echo "$line" >>"$PATH_FILE_LOG"
      printf "$line\n"
    done

  else
    echo "No standard input."
  fi

}

tag_figlet() {
  FIGLET="$NEGRITO"
  FIGLET+="$VERDE"
  FIGLET+="\n"
  FIGLET+="$(figlet -f big "$1")"
  FIGLET+="$NORMAL\n"

  printf "$FIGLET"
  printf "$FIGLET" >>"$PATH_FILE_LOG"
}

# $1 text of tag
# $2 label between bracket
# tag() {
tag_no_figlet() {
  TAG_NO_FIGLET="\n${AZUL}"
  TAG_NO_FIGLET+="####################################################################################################"
  TAG_NO_FIGLET+="${NORMAL}\n"
  TAG_NO_FIGLET+="${AZUL}${2}${NORMAL} ${VERDE}${1}${NORMAL}\n"
  TAG_NO_FIGLET+="${AZUL}"
  TAG_NO_FIGLET+="####################################################################################################"
  TAG_NO_FIGLET+="${NORMAL}"
  printf "$TAG_NO_FIGLET"
  printf "$TAG_NO_FIGLET" >>"$PATH_FILE_LOG"
}

question_tag_no_figlet() {
  tag_no_figlet
  up_one_line
  return_car
}
