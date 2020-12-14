#!/usr/bin/env bash

# General Utils
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias sobash="source ${HOME}/.bashrc"

alias less='less -R'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls -CF --color'
alias ll='ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''
alias npm-globals='npm list --global --depth 0'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias noproxy='unset http_proxy https_proxy ftp_proxy'
alias addproxy='export http_proxy=http://magnum.grob.local:3128 && export https_proxy=$http_proxy'

alias vim='nvim'

alias java-versions='$(echo /usr/libexec/java_home -V) && env | grep JAVA_HOME'

#alias pip='pip2'
#alias python='python2'

# Git
alias g='git'
alias gprune='git remote prune origin && gcleanup'
alias git-default-branch="git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
alias git-checkout-default='git checkout $(git-default-branch)'
alias gcleanup="git-checkout-default &>/dev/null && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"
alias gcp="git checkout -"
