#!/usr/bin/env bash

set -e

linkFiles () {
  for i in $1; do
    ln -sf "${PWD}/${i}" "${HOME}/${i}"
  done
}

FILES="
  .bash_aliases
  .bash_completions
  .bash_profile
  .bash_prompt
  .config/nvim/init.vim
  .config/nvim/colors/bluloco-dark.vim
  .vifm/vifmrc
  .vifm/colors/bluloco-dark.vifm
"

linkFiles "${FILES}"
cp -fa .bashrc .vimrc ${HOME}
! test -f "${HOME}/.bash_custom" && cp ".bash_custom" "${HOME}/.bash_custom"
ditto .vim/colors/bluloco-dark.vim ${HOME}

