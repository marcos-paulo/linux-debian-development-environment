#!/bin/bash
source "./imports.sh"

echo >install-workstation-log.txt

source "./sources/install-figlet.sh"

source "./sources/install-update-system.sh"

source "./sources/install-curl.sh"

source "./sources/install-vscode.sh"

source "./sources/install-jetbrainsmono.sh"

source "./sources/install-git.sh"

source "./sources/install-docker.sh"

source "./sources/install-zsh.sh"

source "./sources/install-node.sh"

source "./sources/install-python3.sh"

source "./sources/install-rust.sh"

source "./sources/install-neovim.sh"

# TODO To implement: show cursor when canceling script execution
tag_figlet "Restart the system"
break_line
show_cursor
