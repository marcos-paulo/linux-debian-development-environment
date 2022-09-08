#!/bin/bash
source "./sources/cores.sh"
source "./sources/ansi-functions.sh"
source "./sources/questions.sh"

echo >install-workstation-log.txt

# O figlet serve apenas para decorar o ShellScript
echo Preparando Instalação
sudo apt install -y figlet >/dev/null 2>&1
# toda a saida da instalação do fliget está sendo direcionada para o /dev/null
# tanto o stdout(>/dev/null) quanto o stderr(2>&1)
# TODO refactore write_log to new file
write_log() {
  msg="$1"
  echo "$msg" >>install-workstation-log.txt
  echo "$msg"
}

# TODO refactore title to new file
title() {
  printf "$NEGRITO"
  printf "$VERDE"
  figlet "$1"
  printf "$NORMAL"
}

# TODO refactore tag to new file
# $1 text of tag
# $2 label between bracket
tag() {
  printf "${AZUL}"
  printf "#####################################################################"
  printf "${NORMAL}\n"
  printf "${AZUL}${2}${NORMAL} ${VERDE}${1}${NORMAL}\n"
  printf "${AZUL}"
  printf "#####################################################################"
  printf "${NORMAL}\n"
}

# TODO refactore tag_question to new file
# TODO BUG erase line from #### when pressing y
tag_question() {
  tag
  up_two_line
  $1 "$2" "$3" "$4"
}

title 'Update System'
sudo apt update
echo update - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

title 'Upgrade System'
sudo apt upgrade -y
echo status upgrade - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

# TODO refactore install curl to new file
title "Install Curl"
sudo apt install curl -y
echo status install curl $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

# TODO refactore install vscode to new file
install_vscode() {
  title "Install VsCode"
  sudo snap install code --classic
  echo status install code $? >>install-workstation-log.txt
  echo >>install-workstation-log.txt
}
tag_question "confirm_question" "Deseja instalar o VsCode?" "install_vscode" "break_two_line"

## TODO refactore install font jetbrainsmono font to install vscode file
install_jet_brains_mono() {
  title "Install JetBrainsMono"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
  echo status install JetBrainsMono $? >>install-workstation-log.txt
  echo >>install-workstation-log.txt
}
tag_question "confirm_question" "Deseja instalar a font JetBrainsMono?" "install_jet_brains_mono" "break_two_line"

# TODO refactore extract function to install-git.sh file
install_git() {
  title "Install Git"
  source "./sources/install-git.sh"
}
tag_question "confirm_question" "Deseja instalar o Git?" "install_git" "break_two_line"

# TODO refactore extract function to "./sources/install-docker.sh" file
install_docker() {
  title "Install Docker"
  source "./sources/install-docker.sh"
}
tag_question "confirm_question" "Deseja instalar o Docker?" "install_docker" "break_two_line"

# TODO refactore extract function to "./sources/install-zsh.sh" file
install_zsh() {
  title "Install Zsh"
  source "./sources/install-zsh.sh"
}
tag_question "confirm_question" "Deseja instalar o zsh?" "install_zsh" "break_two_line"

source "./sources/install-node.sh"

source "./sources/install-neovim.sh"

# TODO To implement: show cursor when canceling script execution
title "Restart the system"
show_cursor
