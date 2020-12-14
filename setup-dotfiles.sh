#!/usr/bin/env bash

set -e

linkFiles() {
  for i in $1; do
    ln -sf "${PWD}/${i}" "${HOME}/${i}"
  done
}

exists() {
  command -v $1 >/dev/null 2>&1
}

FILES="
.bash_aliases
.bash_completions
.bash_profile
.bash_prompt
.zshrc
.config/nvim/init.vim
.vifm/vifmrc
.vifm/colors/bluloco-dark.vifm
.powerline-shell.json
powerline-bluloco-dark.py
"

linkFiles "${FILES}"
cp -fa .bashrc .vimrc ${HOME}
! test -f "${HOME}/.bash_custom" && cp ".bash_custom" "${HOME}/.bash_custom"

# Install vim plugins
vim +PlugInstall +qall

# Install the_silver_searcher
! exists ag && brew install the_silver_searcher
