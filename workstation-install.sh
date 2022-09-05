#!/bin/bash

write_log() {
  msg="$1"
  echo $msg >>install-workstation-log.txt
  echo $msg
}

source ./sources/cores.sh
source ./sources/ansi-functions.sh
echo >install-workstation-log.txt

sudo apt update
echo update - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

sudo apt upgrade -y
echo status upgrade - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

sudo snap install code --classic
echo status install code $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

sudo apt install curl -y
echo status install curl $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
echo status install JetBrainsMono $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

source sources/git-install.sh

source sources/docker_install.sh
