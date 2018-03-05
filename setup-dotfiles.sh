#!/usr/bin/env bash

set -e

linkFiles() {
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
.powerline-shell.json
powerline-bluloco-dark.py
"

linkFiles "${FILES}"
cp -fa .bashrc .vimrc ${HOME}
! test -f "${HOME}/.bash_custom" && cp ".bash_custom" "${HOME}/.bash_custom"
cp -fa --parents .vim/colors/bluloco-dark.vim ${HOME}

# TODO Install via plug, see dimi's init file
# Setup vim plugin manager (pathogen)
NVIM_DIR="${HOME}/.config/nvim"
mkdir -p "${NVIM_DIR}/autoload" "${NVIM_DIR}/bundle" &&
  curl -LSso "${NVIM_DIR}/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
ln -sf "${NVIM_DIR}/autoload" "${HOME}/.vim/autoload"
ln -sf "${NVIM_DIR}/bundle" "${HOME}/.vim/bundle"

# Install vim plugins
CWD="${PWD}"
cd "${NVIM_DIR}/bundle/"
! test -d vim-surround && git clone https://github.com/tpope/vim-surround.git
! test -d vim-gitgutter && git clone https://github.com/airblade/vim-gitgutter.git
cd "${CWD}"
