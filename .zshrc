# homebrew auto completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/uloco/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf cp autojump colored-man-pages colorize github node nvm npm docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

##### CUSTOM #####

# Set language
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_NUMERIC="de_DE.UTF-8"
export LC_TIME="de_DE.UTF-8"
export LC_MONETARY="de_DE.UTF-8"
export LC_PAPER="de_DE.UTF-8"
export LC_IDENTIFICATION="de_DE.UTF-8"
export LC_NAME="de_DE.UTF-8"
export LC_ADDRESS="de_DE.UTF-8"
export LC_TELEPHONE="de_DE.UTF-8"
export LC_MEASUREMENT="de_DE.UTF-8"

# Java
export JAVA_HOME="/Library/Java/Home"

# Android
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Add local binaries to path
export PATH="${PATH}:${HOME}/.local/bin"

# Use gnu implementations instead of bsd
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

export PATH="/usr/local/sbin:$PATH"

# python2
export PATH="/usr/local/opt/python@2/libexec/bin:${PATH}"
#
# python3
export PATH="${HOME}/Library/Python/3.8/bin:${PATH}"

export EDITOR="nvim"

# composer
export PATH="${HOME}/.composer/vendor/bin:$PATH"

# rvm ruby
export PATH="${HOME}/.gem/bin:$PATH"

alias ls='ls -CF --color'
alias ll='ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''
alias npm-globals='npm ls -g'
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

# Android Emulator dns
alias android-emulator-dns='~/Library/Android/sdk/emulator/emulator @Pixel_XL_API_29 -dns-server 192.168.8.1'

# Powerline Go
# function powerline_precmd() {
#     PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh)"
# }

# function install_powerline_precmd() {
#   for s in "${precmd_functions[@]}"; do
#     if [ "$s" = "powerline_precmd" ]; then
#       return
#     fi
#   done
#   precmd_functions+=(powerline_precmd)
# }

# if [ "$TERM" != "linux" ]; then
#     install_powerline_precmd
# fi

# Powerline Shell
function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

# add ssh key to git
ssh-add ~/.ssh/gitlab &>/dev/null

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go Lang
export GOPATH="${HOME}/go"

# Ruby
# export GEM_HOME="${HOME}/.gem"
# eval "$(rbenv init -)"

# Smokeless Android
export KEYSTORE_FILE="smokeless-world.keystore"
export KEYSTORE_PASSWORD="T36G7rJfYANqFg1FMRTE"
export RELEASE_KEY_ALIAS="smokeless-world"
export RELEASE_KEY_PASSWORD="dlh2Gi6yW5CEFNQCyYgT"
export DEV_KEY_ALIAS="smokeless-world-development"
export DEV_KEY_PASSWORD="kkzOeg0C6FbN3imbD6Bc"
export STAGE_KEY_ALIAS="smokeless-world-stage"
export STAGE_KEY_PASSWORD="dYPoG7W8kqKGxyfO59le"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
