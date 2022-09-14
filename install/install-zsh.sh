#!/bin/bash

install_zsh() {
  tag_no_figlet "Instaling... ZSH"
  break_line
  sudo apt install -y zsh 2>&1 | write_log
}

default_shell() {
  # chsh - ChangeShell
  tag_no_figlet "Set zsh as default shell"
  break_line
  sudo chsh -s /bin/zsh 2>&1 | write_log
}

create_zshrc() {
  tag_no_figlet "Create file .zshrc"
  break_line
  touch ~/.zshrc 2>&1 | write_log
}

font_meslo_lgs() {
  tag_no_figlet "Install MesloLGS"
  break_line
  sudo mkdir -p "/usr/share/fonts/truetype/MesloLGS"
  sudo cp ./fonts/* /usr/share/fonts/truetype/MesloLGS/ 2>&1 | write_log
  fc-cache -f
}

powerlevel10k() {
  tag_no_figlet "Install powerlevel10k"
  break_line
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 2>&1 | write_log
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
  # p10k configure - para configurar o powerlevel10k
}

copy_p10k_profile() {
  tag_no_figlet "Copy powerlevel10k profile .p10k.zsh for $HOME"
  break_line
  cp "./sources/.p10k.zsh" "$HOME/"
  echo "# To customize prompt, run \$(p10k configure) or edit ~/.p10k.zsh." >>~/.zshrc
  echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>~/.zshrc
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
