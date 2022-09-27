#!/bin/bash
install_google_chrome() {
  tag_figlet "Install GoogleChrome"

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL "https://dl.google.com/linux/linux_signing_key.pub" |
    sudo gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg

  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] \
    http://dl.google.com/linux/chrome/deb/ stable main" |
    sudo tee /etc/apt/sources.list.d/google-chrome.list

  sudo apt-get update

  sudo apt install -y google-chrome-stable

}

question_tag_no_figlet
confirm_question "Deseja instalar GoogleChrome?" \
  -y "break_two_line" "install_google_chrome" \
  -n "break_two_line"
