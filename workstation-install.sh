#!/bin/bash
path_sh=$(pwd)
source "./util/print_log.sh"
source "./util/separator_params.sh"
source "./util/command-test.sh"
source "./sources/cores.sh"
source "./sources/ansi-functions.sh"
source "./sources/questions.sh"

echo >install-workstation-log.txt

# O figlet serve apenas para decorar o ShellScript
echo Preparando Instalação
sudo apt install -y figlet >/dev/null 2>&1
# toda a saida da instalação do fliget está sendo direcionada para o /dev/null
# tanto o stdout(>/dev/null) quanto o stderr(2>&1)

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

source "./sources/install-python3.sh"

source "./sources/install-rust.sh"

source "./sources/install-neovim.sh"

# TODO To implement: show cursor when canceling script execution
title "Restart the system"
show_cursor
