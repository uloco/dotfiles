export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH

## Fast Node Manager (for non-interactive login shells like Neovide)
export RCFILE="$HOME/.zshrc"
if [[ ! -o interactive ]]; then
  eval "$(fnm env --use-on-cd --version-file-strategy recursive)"
fi
