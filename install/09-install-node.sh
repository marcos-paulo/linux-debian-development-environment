#!/bin/bash
install_nodejs() {
  tag_figlet "Install Node"
  break_line
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs 2>&1 | write_log
  sudo npm install --global yarn 2>&1 | write_log
}

question_tag_no_figlet
confirm_question "Deseja instalar o NodeJs" \
  -y "break_two_line" "install_nodejs" \
  -n "break_two_line"
