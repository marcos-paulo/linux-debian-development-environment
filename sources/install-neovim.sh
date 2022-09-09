#!/bin/bash
PATH_TO_INSTALL="$HOME/.neovim"

# for build for neovim
# https://github.com/neovim/neovim/wiki/Building-Neovim

install_dependencies_neovim() {
  tag "Install dependencies for build" "[NeoVim]"
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
}

remove_current_neovim() {
  tag "Removendo instalaçao anterior!" "[NeoVim]"
  sudo rm -rf $PATH_TO_INSTALL
}

download_source_neovim() {
  tag "Downloading source neovim..." "[NeoVim]"
  # sudo rm -rf /tmp/neovim
  mkdir -p /tmp/neovim
  cd /tmp/neovim
  # git clone https://github.com/neovim/neovim
  cd neovim
  git checkout stable
}

build_neovim() {
  tag "Building neovim..." "[NeoVim]"
  sudo rm -rf build/ # clear the CMake cache
  # make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PATH_TO_INSTALL" >"${path_sh}/install_neovim_make.txt" 2>&1
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PATH_TO_INSTALL" 2>&1 | getInput
}

install_neovim() {
  tag "Installing neovim..." "[NeoVim]"
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
  tag_question "confirm_question" "Neovim já instalado, deseja reinstalá-lo?" "run_install_neovim" "break_two_line"
}

test_neovim() {
  title "Install NeoVim"
  command_test "nvim" "already_installed" "run_install_neovim"

}

# TODO implement LunarVim installation in latest version
install_lunarvim() {
  title "Install LunarVim"
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

install() {
  test_neovim
  install_lunarvim
}

tag_question "confirm_question" "Deseja instalar o NeoVim e o LunarVim?" "install" "break_two_line"

cd "$path_sh"
