#!/bin/bash
PATH_NEOVIM="$HOME/.neovim"
BIN_NVIM="$PATH_NEOVIM/bin"

BIN_LVIM="$HOME/.local/bin"

# for build for neovim
# https://github.com/neovim/neovim/wiki/Building-Neovim

install_dependencies_neovim() {
  tag_no_figlet "Install dependencies for build" "[NeoVim]"
  break_line
  sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
}

remove_current_neovim() {
  tag_no_figlet "Removendo instalaçao anterior!" "[NeoVim]"
  break_line
  sudo rm -rf $PATH_NEOVIM
}

download_source_neovim() {
  tag_no_figlet "Downloading source neovim..." "[NeoVim]"
  break_line
  sudo rm -rf /tmp/neovim
  mkdir -p /tmp/neovim
  cd /tmp/neovim
  git clone https://github.com/neovim/neovim
  cd neovim
  git checkout stable
}

build_neovim() {
  tag_no_figlet "Building neovim..." "[NeoVim]"
  break_line
  sudo rm -rf build/ # clear the CMake cache
  break_line
  progress_bar_log_file="building_neovim.txt"
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PATH_NEOVIM" 2>&1 | progress_bar
  break_line
}

install_neovim() {
  tag_no_figlet "Installing neovim..." "[NeoVim]"
  break_line
  sudo make install >"${path_sh}/log/install_neovim_install.txt" 2>&1

  test_and_export_bin_path_in_shell_rc_file "$BIN_NVIM" "$HOME/.bashrc"
  test_and_export_bin_path_in_shell_rc_file "$BIN_NVIM" "$HOME/.zshrc"

  tag_no_figlet "Installation performed successfully" "[NeoVim]"
  break_line

}

export_path_nvim() {
  test_and_export_path_environment_in_this_shell "$BIN_NVIM"
}

run_install_neovim() {
  install_dependencies_neovim
  remove_current_neovim
  download_source_neovim
  build_neovim
  install_neovim
  export_path_nvim
}

already_installed() {
  question_tag_no_figlet
  confirm_question "Neovim já instalado, deseja reinstalá-lo?" \
    -y "break_two_line" "run_install_neovim" \
    -n "break_two_line"
}

test_neovim() {
  tag_figlet "Install NeoVim"
  break_line
  command_test "nvim" "already_installed" "run_install_neovim"
}

question_tag_no_figlet
confirm_question "Deseja instalar o NeoVim?" \
  -y "break_two_line" "test_neovim" \
  -n "break_two_line"

install_lunarvim() {
  tag_figlet "Install LunarVim"
  break_line
  test_and_export_bin_path_in_shell_rc_file "$BIN_LVIM" "$HOME/.bashrc"
  test_and_export_bin_path_in_shell_rc_file "$BIN_LVIM" "$HOME/.zshrc"
  test_and_export_path_environment_in_this_shell "$BIN_LVIM"
  /bin/bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"
}

question_tag_no_figlet
confirm_question "Deseja instalar o LunarVim?" \
  -y "break_two_line" "install_lunarvim" \
  -n "break_two_line"

cd "$path_sh"
