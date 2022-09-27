#!/bin/bash

install_rust_cargo() {
  tag_figlet "Install Rust Cargo"
  break_line
  curl https://sh.rustup.rs -sSf | sh

  echo ". \"$HOME/.cargo/env\"" >>$HOME/.zshrc
  source "$HOME/.cargo/env"
}

question_tag_no_figlet
confirm_question "Deseja instalar o Rust-Cargo" \
  -y "break_two_line" "install_rust_cargo" \
  -n "break_two_line"
