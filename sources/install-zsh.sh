#!/bin/bash
sudo apt install -y zsh

tag "Set zsh as default shell"
chsh -s /bin/zsh

tag "Create file .zshrc"
touch ~/.zshrc

# tag "Install 'oh my zsh'"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# tag "Install fonts-powerline"
# sudo apt-get install fonts-powerline

tag "Install MesloLGS"
sudo mkdir -p "/usr/share/fonts/truetype/MesloLGS"
sudo cp ./fonts/* /usr/share/fonts/truetype/MesloLGS/
fc-cache -f

tag "Install powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
