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


# Alias definitions.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Custom prompt
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

# Bash completions
[ -f ~/.bash_completions ] && source ~/.bash_completions

# Bash environment
[ -f ~/.bash_env ] && source ~/.bash_env

