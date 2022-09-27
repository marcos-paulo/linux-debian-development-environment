#!/bin/bash

# O figlet serve apenas para decorar o ShellScript
echo Preparando Instalação
sudo apt update
sudo apt install -y figlet >/dev/null 2>&1
# toda a saida da instalação do fliget está sendo direcionada para o /dev/null
# tanto o stdout(>/dev/null) quanto o stderr(2>&1)
