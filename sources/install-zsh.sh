#!/bin/bash
sudo apt install -y zsh

# TODO Refactore: Add functions, questions and optimize the file
# chsh - ChangeShell
tag_no_figlet "Set zsh as default shell"
break_line
chsh -s /bin/zsh

tag_no_figlet "Create file .zshrc"
break_line
touch ~/.zshrc

# tag_no_figlet "Install 'oh my zsh'"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# tag_no_figlet "Install fonts-powerline"
# sudo apt-get install fonts-powerline

tag_no_figlet "Install MesloLGS"
break_line
sudo mkdir -p "/usr/share/fonts/truetype/MesloLGS"
sudo cp ./fonts/* /usr/share/fonts/truetype/MesloLGS/
fc-cache -f

tag_no_figlet "Install powerlevel10k"
break_line
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
# p10k configure - para configurar o powerlevel10k
