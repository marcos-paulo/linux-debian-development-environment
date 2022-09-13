#!/bin/bash

install_vscode() {
  tag_figlet "Install VsCode"
  break_line
  sudo snap install code --classic
  echo status install code $? >>install-workstation-log.txt
  echo >>install-workstation-log.txt
}

question_tag_no_figlet
confirm_question "Deseja instalar o VsCode?" \
  -y "install_vscode" \
  -n "break_two_line"
