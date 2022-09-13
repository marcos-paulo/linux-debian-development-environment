#!/bin/bash

install_zsh() {
  tag_no_figlet "Instaling... ZSH"
  break_line
  sudo apt install -y zsh
}

default_shell() {
  # chsh - ChangeShell
  tag_no_figlet "Set zsh as default shell"
  break_line
  chsh -s /bin/zsh
}

create_zshrc() {
  tag_no_figlet "Create file .zshrc"
  break_line
  touch ~/.zshrc
}

font_meslo_lgs() {
  tag_no_figlet "Install MesloLGS"
  break_line
  sudo mkdir -p "/usr/share/fonts/truetype/MesloLGS"
  sudo cp ./fonts/* /usr/share/fonts/truetype/MesloLGS/
  fc-cache -f
}

powerlevel10k() {
  tag_no_figlet "Install powerlevel10k"
  break_line
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
  # p10k configure - para configurar o powerlevel10k
}

copy_p10k_profile() {
  tag_no_figlet "Copy powerlevel10k profile .p10k.zsh for $HOME"
  cp "./sources/.p10k.zsh" "~/"
}

main_zsh() {
  tag_figlet "Install Zsh"
  install_zsh
  default_shell
  create_zshrc
  font_meslo_lgs
  powerlevel10k
  copy_p10k_profile
}

question_tag_no_figlet
confirm_question "Deseja instalar o zsh?" \
  -y "break_two_line" "main_zsh" \
  -n "break_two_line"
