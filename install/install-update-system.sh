#!/bin/bash

tag_figlet 'Update System'
break_line
sudo apt update
echo update - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt

tag_figlet 'Upgrade System'
break_line
sudo apt upgrade -y
echo status upgrade - $? >>install-workstation-log.txt
echo >>install-workstation-log.txt
