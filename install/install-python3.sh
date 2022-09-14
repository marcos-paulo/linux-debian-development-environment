#!/bin/bash

install_python3_pip() {
  tag_figlet "Install python3-pip"
  break_line
  sudo apt install -y python3-pip 2>&1 | write_log
}
question_tag_no_figlet
confirm_question "Deseja instalar o Python3-pip?" \
  -y "break_two_line" "install_python3_pip" \
  -n "break_two_line"
