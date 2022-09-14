#!/bin/bash

install_vscode() {
  tag_figlet "Install VsCode"
  sudo snap install code --classic 2>&1 | write_log
}

question_tag_no_figlet
confirm_question "Deseja instalar o VsCode?" \
  -y "break_two_line" "install_vscode" \
  -n "break_two_line"
