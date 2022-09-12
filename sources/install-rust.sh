#!/bin/bash

install_rust_cargo() {
  tag_figlet "Install Rust Cargo"
  break_line
  curl https://sh.rustup.rs -sSf | sh
  echo "source \"$HOME/.cargo/env\"" >>$HOME/.bashrc
  echo "source \"$HOME/.cargo/env\"" >>$HOME/.zshrc
  source "$HOME/.cargo/env"
}
question_tag_no_figlet
confirm_question "Deseja instalar o Rust-Cargo" "install_rust_cargo" "break_two_line"
