#!/bin/bash
install_any_desc() {
  tag_figlet "Install AnyDesc"

  sudo mkdir -p /etc/apt/keyrings
  # - add repository key to Trusted software providers list
  curl -fsSL "https://keys.anydesk.com/repos/DEB-GPG-KEY" |
    sudo gpg --dearmor -o /etc/apt/keyrings/anydesk-stable.gpg
  # - add the repository:
  echo \
    "deb [signed-by=/etc/apt/keyrings/anydesk-stable.gpg] \
    http://deb.anydesk.com/ all main" |
    sudo tee /etc/apt/sources.list.d/anydesk-stable.list
  # - update apt cache:
  sudo apt update
  # - install anydesk:
  sudo apt install -y anydesk
}

question_tag_no_figlet
confirm_question "Deseja instalar AnyDesc?" \
  -y "break_two_line" "install_any_desc" \
  -n "break_two_line"
