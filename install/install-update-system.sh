#!/bin/bash

tag_figlet 'Update System'
sudo apt update 2>&1 | write_log

tag_figlet 'Upgrade System'
sudo apt upgrade -y 2>&1 | write_log
