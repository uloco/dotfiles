## Fast Node Manager
export RCFILE="$HOME/.zshrc"
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

# Include
source "${HOME}/.zsh_keys"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# measure shell startup time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# homebrew auto completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

ZSH_DISABLE_COMPFIX=true


# Path to your oh-my-zsh installation.
export ZSH="/Users/uloco/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

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


# FZF
export FZF_DEFAULT_OPTS='
--color fg:-1,bg:-1,hl:12,fg+:15,bg+:0,hl+:12
--color info:5,border:6,prompt:10,pointer:9,marker:12,spinner:4,header:14
'

zstyle ':fzf-tab:*' default-color $'\033[38m'
zstyle ':fzf-tab:*' fzf-flags --color='fg:-1,bg:-1,hl:12,fg+:15,bg+:0,hl+:12'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

plugins=(fzf cp autojump colored-man-pages colorize github node npm docker pod fzf-tab)

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
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-16.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-16.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home/"

# Android
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Add local binaries to path
export PATH="${PATH}:${HOME}/.local/bin"

# Use gnu implementations instead of bsd
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
# export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

export PATH="/usr/local/sbin:$PATH"

## python2
#export PATH="/usr/local/opt/python@2/libexec/bin:${PATH}"

## python3
export PATH="${HOME}/Library/Python/3.9/bin:${PATH}"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:${PATH}"

# alias python=/usr/local/bin/python3

export EDITOR="nvim"

# composer
export PATH="${HOME}/.composer/vendor/bin:$PATH"

# gnu ls
alias ls='gls -CF --color'
alias ll='ls -AlF --group-directories-first'
alias la='ls -A'
alias l='ls'

# gnu cp
alias cp="gcp"

# gnu rm
alias rm="grm"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''
alias npm-globals='npm ls -g'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vim='nvim'

alias java-versions='$(echo /usr/libexec/java_home -V) && env | grep JAVA_HOME'

#alias pip='pip2'
#alias python='python2'

# Git
alias g='git'

# Android Emulator dns
alias android-emulator-dns='~/Library/Android/sdk/emulator/emulator @Pixel_XL_API_29 -dns-server 192.168.8.1'

# # Ruby
export GEM_HOME="${HOME}/.gem"
export PATH=$GEM_HOME/bin:$PATH

# homebrew ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH

# eval "$(rbenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
alias nvm="fnm"

# brew intel
alias brew-intel="/usr/local/bin/brew"

***REMOVED***
***REMOVED***


# GIF
alias whoah="gif-for-cli \"mindblown\""

# Android Studio
alias android-studio="open -a /Applications/Android\ Studio.app"
alias npm-clean-install="rm -rf package-lock.json node_modules ios/Pods ios/Podfile.lock && npm i"

# 1Password CLI completion
eval "$(op completion zsh)"; compdef _op op

alias rosetta="arch -x86_64"
alias cat="bat"

# bun completions
[ -s "/Users/uloco/.bun/_bun" ] && source "/Users/uloco/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/uloco/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Lazygi-modet
export CONFIG_DIR=${HOME}/.config/lazygit

function get_macos_theme () {
  defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light
}

function lazygit () {
  THEME=$(get_macos_theme)
  CONFIG_BASE=${CONFIG_DIR}/config.yml
  CONFIG_THEME=${CONFIG_DIR}/config-${THEME}.yml

  command lazygit --use-config-file=${CONFIG_BASE},${CONFIG_THEME} $@
}
}
