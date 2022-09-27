#!/bin/bash
install_beekeeper_studio() {
  tag_figlet "Install BeekeeperStudio"
  # Install our GPG key
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL "https://deb.beekeeperstudio.io/beekeeper.key" |
    sudo gpg --dearmor -o /etc/apt/keyrings/beekeeper-studio.gpg

  # add our repo to your apt lists directory
  echo "deb [signed-by=/etc/apt/keyrings/beekeeper-studio.gpg] \
    https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list

  # Update apt and install
  sudo apt update
  sudo apt install -y beekeeper-studio
}

question_tag_no_figlet
confirm_question "Deseja instalar BeekeeperStudio?" \
  -y "break_two_line" "install_beekeeper_studio" \
  -n "break_two_line"
