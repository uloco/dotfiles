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
.config/nvim/colors/bluloco-dark.vim
.vifm/vifmrc
.vifm/colors/bluloco-dark.vifm
.powerline-shell.json
powerline-bluloco-dark.py
"

linkFiles "${FILES}"
cp -fa .bashrc .vimrc ${HOME}
! test -f "${HOME}/.bash_custom" && cp ".bash_custom" "${HOME}/.bash_custom"
cp -fa --parents .vim/colors/bluloco-dark.vim ${HOME}

# Install git-subrepo
export SUBREPO_PATH="${HOME}/Source/git-subrepo" 
! test -d "${SUBREPO_PATH}" &&
  git clone https://github.com/ingydotnet/git-subrepo "${SUBREPO_PATH}"

# Install the_silver_searcher
! exists ag && brew install the_silver_searcher
