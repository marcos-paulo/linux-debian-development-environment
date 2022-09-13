#!/bin/bash

tag_figlet "Install Curl"
break_line
sudo apt install curl -y
echo status install curl $? >>install-workstation-log.txt
echo >>install-workstation-log.txt
