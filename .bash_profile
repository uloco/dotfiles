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
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Custom prompt
if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi

# Bash completions
if [ -f ~/.bash_completions ]; then
    source ~/.bash_completions
fi

# Setup android
export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}
export PATH=${PATH}:${ANDROID_HOME}/bin
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Add local binaries to path
export PATH="${PATH}:${HOME}/.local/bin"

# Use gnu implementations instead of bsd
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

export PATH="/usr/local/sbin:$PATH"

# WORK ################################################################

# Proxy
# export http_proxy=http://localhost:3128
# export https_proxy=http://localhost:3128
# export http_proxy=http://magnum.grob.local:3128
# export https_proxy=http://magnum.grob.local:3128
# export no_proxy="localhost, 127.0.0.1, gmvm003lx, 172.28.0.66"

# begin gnux completion
# source /Users/topuzoglu/.gnux/completion.sh
# end gnux completion

