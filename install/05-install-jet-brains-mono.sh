#!/bin/bash

install_jet_brains_mono() {
  tag_figlet "Install JetBrainsMono"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)" \
    2>&1 | write_log
}

question_tag_no_figlet
confirm_question "Deseja instalar a font JetBrainsMono?" \
  -y "break_two_line" "install_jet_brains_mono" \
  -n "break_two_line"
