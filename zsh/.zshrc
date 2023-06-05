# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

## Fast Node Manager
export RCFILE="$HOME/.zshrc"
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

# Include
source "${HOME}/.zsh_keys"

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


# k9s completion
source <(kubectl completion zsh)

ZSH_DISABLE_COMPFIX=true


# Path to your oh-my-zsh installation.
export ZSH="/Users/uloco/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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

# Keep history
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

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
# Add mason neovim binaries to path
export PATH="${PATH}:${HOME}/.local/share/nvim/mason/bin"

# Use gnu implementations instead of bsd
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
# export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

export PATH="/usr/local/sbin:$PATH"

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

alias vim='nvim --listen /tmp/nvimsocket'

alias java-versions='$(echo /usr/libexec/java_home -V) && env | grep JAVA_HOME'

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


# eval "$(rbenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
alias nvm="fnm"

# brew intel
alias brew-intel="/usr/local/bin/brew"

# GIF
alias whoah="gif-for-cli \"mindblown\""

# Android Studio
alias android-studio="open -a /Applications/Android\ Studio.app"
alias npm-clean-install="rm -rf package-lock.json node_modules ios/Pods ios/Podfile.lock && npm i"

# 1Password CLI completion
eval "$(op completion zsh)"; compdef _op op

alias rosetta="arch -x86_64"

# bun completions
[ -s "/Users/uloco/.bun/_bun" ] && source "/Users/uloco/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/uloco/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


function get_macos_theme () {
  defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light
}

# Lazygit
export XDG_CONFIG_DIR=${HOME}/.config

function lazygit () {
  THEME=$(get_macos_theme)
  CONFIG_BASE=${XDG_CONFIG_DIR}/lazygit/config.yml
  CONFIG_THEME=${XDG_CONFIG_DIR}/lazygit/config-${THEME}.yml

  command lazygit --use-config-file=${CONFIG_BASE},${CONFIG_THEME} $@
}
alias lg='lazygit'

function sad() {
  export GIT_PAGER="delta --features $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark-mode || echo light-mode)"
  command sad $@
}

function bat() {
  THEME=$(get_macos_theme)

  if [[ ${THEME} = "dark" ]]; then
    export BAT_CONFIG_PATH="${HOME}/.config/bat/config-dark.conf"
  else
    export BAT_CONFIG_PATH="${HOME}/.config/bat/config-light.conf"
  fi

  command bat $@
}

alias cat="bat"

export REACT_EDITOR="nvr"

alias find_secure_input="ioreg -l -w 0 |  tr ',' '\n' 2&> /dev/null | grep kCGSSessionSecureInputPID | cut -f 2 -d = | uniq | xargs ps -o command= -p"

