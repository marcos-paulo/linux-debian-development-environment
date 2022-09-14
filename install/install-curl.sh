#!/bin/bash

tag_figlet "Install Curl"
sudo apt install curl -y 2>&1 | write_log
