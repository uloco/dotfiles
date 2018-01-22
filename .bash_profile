# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=20

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

include () {
  [[ -f "$1" ]] && source $1
}

# Alias definitions.
include "${HOME}/.bash_aliases"

# Custom prompt
include "${HOME}/.bash_prompt"

# Bash completions
include "${HOME}/.bash_completions"

# Bash custom stuff
include "${HOME}/.bash_custom"

