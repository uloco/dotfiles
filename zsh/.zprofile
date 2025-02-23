export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH

## Fast Node Manager
export RCFILE="$HOME/.zshrc"
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"
