#!/usr/bin/env bash

set -e
CWD="${0%/*}"

linkFiles () {
  for i in $1; do
    ln -sf "${PWD}/${i}" "${HOME}/${i}"
  done
}

linkFiles ".bash_*"
linkFiles ".config/nvim/init.vim"
linkFiles ".config/nvim/colors/bluloco-dark.vim"
linkFiles ".vifm/vifmrc"
linkFiles ".vifm/colors/bluloco-dark.vifm"

cp -a .bashrc .vimrc ${HOME}
cp --parents .vim/colors/bluloco-dark.vim ${HOME}

