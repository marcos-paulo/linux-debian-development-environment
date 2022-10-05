#!/bin/bash
install_virtual_box() {
  tag_figlet "Install VirtualBox"

  sudo mkdir -p "/etc/apt/keyrings"
  file_gpg="/etc/apt/keyrings/oracle-virtualbox-2016.gpg"

  curl -fsSL "https://www.virtualbox.org/download/oracle_vbox_2016.asc" |
    sudo gpg --dearmor --yes -o "$file_gpg"

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=$file_gpg] \
    https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" |
    sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list

  sudo apt update
  sudo apt install -y virtualbox-6.1

}

question_tag_no_figlet
confirm_question "Deseja instalar VirtualBox?" \
  -y "break_two_line" "install_virtual_box" \
  -n "break_two_line"
