#!/bin/bash
install_nodejs() {
  tag_figlet "Install Node"
  break_line
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo npm install --global yarn
}
tag_question "confirm_question" "Deseja instalar o NodeJs" "install_nodejs" "break_two_line"
