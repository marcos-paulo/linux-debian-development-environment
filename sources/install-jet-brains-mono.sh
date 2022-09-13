#!/bin/bash

install_jet_brains_mono() {
  tag_figlet "Install JetBrainsMono"
  break_line
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
  echo status install JetBrainsMono $? >>install-workstation-log.txt
  echo >>install-workstation-log.txt
}

question_tag_no_figlet
confirm_question "Deseja instalar a font JetBrainsMono?" \
  -y "install_jet_brains_mono" \
  -n "break_two_line"
