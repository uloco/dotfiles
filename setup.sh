#!/usr/bin/env bash

set -e

linkFiles () {
  CWD="${0%/*}"
  for i in $1; do
    ln -sf "${i}" "${HOME}/${i}"
  done
}

linkFiles "$CWD/.bash*"
linkFiles "$CWD/.config/nvim/init.vim"
linkFiles "$CWD/.config/nvim/colors/bluloco-dark-vim"
linkFiles "$CWD/.vifm/vifmrc"
linkFiles "$CWD/.vifm/colors/bluloco-dark.vifm"

cp -a .bashrc .vimrc $HOME

