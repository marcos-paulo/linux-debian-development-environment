#!/bin/bash

install_python3_pip() {
  tag_figlet "Install python3-pip"
  break_line
  sudo apt install -y python3-pip >install-python3.txt 2>&1
}
tag_question "confirm_question" "Deseja instalar o Python3-pip?" "install_python3_pip" "break_two_line"
