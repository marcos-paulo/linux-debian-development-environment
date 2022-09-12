#!/bin/bash
PATH_TO_INSTALL="$HOME/.neovim"

# for build for neovim
# https://github.com/neovim/neovim/wiki/Building-Neovim

install_dependencies_neovim() {
  tag_no_figlet "Install dependencies for build" "[NeoVim]"
  break_line
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
}

remove_current_neovim() {
  tag_no_figlet "Removendo instalaçao anterior!" "[NeoVim]"
  break_line
  sudo rm -rf $PATH_TO_INSTALL
}

download_source_neovim() {
  tag_no_figlet "Downloading source neovim..." "[NeoVim]"
  break_line
  # sudo rm -rf /tmp/neovim
  mkdir -p /tmp/neovim
  cd /tmp/neovim
  # git clone https://github.com/neovim/neovim
  cd neovim
  git checkout stable
}

build_neovim() {
  tag_no_figlet "Building neovim..." "[NeoVim]"
  break_line
  sudo rm -rf build/ # clear the CMake cache
  # make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PATH_TO_INSTALL" >"${path_sh}/install_neovim_make.txt" 2>&1
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PATH_TO_INSTALL" 2>&1 | getInput
}

install_neovim() {
  tag_no_figlet "Installing neovim..." "[NeoVim]"
  break_line
  sudo make install >"${path_sh}/install_neovim_install.txt" 2>&1
  echo "export PATH=\"$PATH_TO_INSTALL/bin:\$PATH\"" >>$HOME/.bashrc
  echo "export PATH=\"$PATH_TO_INSTALL/bin:\$PATH\"" >>$HOME/.zshrc

}

run_install_neovim() {
  install_dependencies_neovim
  remove_current_neovim
  download_source_neovim
  build_neovim
  install_neovim
}

already_installed() {
  question_tag_no_figlet
  confirm_question "Neovim já instalado, deseja reinstalá-lo?" -y "break_two_line" "run_install_neovim" -n "break_two_line"
}

test_neovim() {
  tag_figlet "Install NeoVim"
  break_line
  command_test "nvim" "already_installed" "run_install_neovim"

}

# TODO implement LunarVim installation in latest version
install_lunarvim() {
  tag_figlet "Install LunarVim"
  break_line
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

install() {
  test_neovim
  install_lunarvim
}

question_tag_no_figlet
confirm_question "Deseja instalar o NeoVim e o LunarVim?" -y "break_two_line" "install" -n "break_two_line"
# tag_question

cd "$path_sh"
