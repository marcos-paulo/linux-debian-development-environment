#!/bin/bash
path_sh=$(pwd)
mkdir -p log

# path_scripts=$(echo $0 | sed "s|/workstation-install.sh||g ")
# echo path $path_scripts

for indiceFileA in $path_sh/util/*.sh; do
  echo "util $indiceFileA"
  if [ -r $indiceFileA ]; then
    . "$indiceFileA"
  fi
done
unset indiceFileA

for indiceFileB in $path_sh/install/*.sh; do
  if [ -r $indiceFileB ]; then
    . "$indiceFileB"
  fi
done
unset indiceFileB

tag_figlet "Restart the system"
break_line
show_cursor
