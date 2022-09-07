#!/bin/bash
# TODO implement neovim installation in latest version
install_neovim() {
  title "Install NeoVim"
  # sudo apt install -y neovim
}

# TODO implement LunarVim installation in latest version
install_lunarvim() {
  title "Install LunarVim"
  # bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

install() {
  install_neovim
  install_lunarvim
}

tag_question "confirm_question" "Deseja instalar o NeoVim e o LunarVim?" "install" "break_two_line"
