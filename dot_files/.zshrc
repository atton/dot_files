autoload -Uz compinit add-zsh-hook zmv is-at-least

# complete enable
compinit

# {{{ environment variables

# languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# for tmuxinator
export EDITOR=vim

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.cabal/bin:$PATH
export LIBRARY_PATH=/usr/local/lib:/usr/lib:$LIBRARY_PATH

# Path for specific environment
if [[  $(uname) == Darwin ]]; then
    export PATH=/usr/texbin:$PATH
    export ANDROID_HOME=/usr/local/opt/android-sdk
    export PATH=$ANDROID_HOME/bin:$PATH
else
    export PATH=$HOME/.rbenv/bin:$PATH
fi


# }}}

# options {{{
# emacs like key binding
bindkey -e

# number of history
HISTSIZE=10000

# if type command already added in history, not add in history
setopt hist_ignore_dups

# delete duplicate path
typeset -U path cdpath fpath manpath

# delete duplicate directory in directory stack
setopt pushd_ignore_dups

# beep disable in list completion
setopt nolistbeep

# beep disable
setopt no_beep

# disable flow control (disable ^q,^s)
setopt no_flow_control

# disable combine multi byte character on completion
setopt combining_chars

# ignore current directory when 'cd ..' completion
zstyle ':completion:*' ignore-parents parent pwd ..

# prompt format
PROMPT="%m%# "                      # left prompt
RPROMPT="[%~]%1(v|%1v|)"            # right prompt
setopt transient_rprompt            # if typed chars conflict right prompt, hide right prompt

# vcs_info (zsh support vcs_info after 4.3.11)
if is-at-least 4.3.11; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' unstagedstr   '+'
    zstyle ':vcs_info:*' formats       '%u(%s|%b)'
    zstyle ':vcs_info:*' actionformats '%u(%s|%b|%a)'
    precmd () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
fi

# }}}

# aliases {{{

alias vimp="vim -c 'set rtp+=.'"

alias pin="ping 8.8.8.8"
alias ipin="nslookup www.google.com"

alias be='bundle exec'
alias bet='RAILS_ENV=test bundle exec'
alias bep='RAILS_ENV=production bundle exec'

# OSX only

if [[  $(uname) == Darwin ]]; then
    alias wine='LC_ALL=ja_JP.UTF-8 wine'
fi

# }}}

# functions {{{

# custom cd (if type only 'cd', call pushd)
function cd() {
    if [ $# -eq 0 ]; then
        # if have no arguments, pushd $HOME
        builtin pushd $HOME
    else
        # if have arguments, builtin cd
        builtin cd $@
    fi
}

# Heavy initialization
function shell-init() {
    # initialize rbenv with rehash
    if which rbenv >& /dev/null; then eval "$(rbenv init - zsh)"; fi

    # initialize noir completion
    if noir -v >& /dev/null; then eval "$(noir init zsh)"; fi

    # source util functions
    source $HOME/.zshrc.util
}

# }}}

# settings for specific command {{{

# Ruby
# initialize rbenv without rehash (rehash operation is heavy...)
if which rbenv >& /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi
# ruby-build
export RUBY_CONFIGURE_OPTS="--enable-shared"

# Java
# alias to set encoding
alias javac='javac -J-Dfile.encoding=UTF8'
alias java='java -Dfile.encoding=UTF8'

# git
# file name completion in git command, use normal file name completion
__git_files() { _files }

# mercurial
export HGENCODING=UTF-8

# direnv
if which direnv >& /dev/null; then eval "$(direnv hook zsh)"; fi

# }}}

#  {{{ source local zshrc
localzshrc=$HOME/.zshrc.local

if [ -f $localzshrc ]; then
    source $localzshrc
fi

# }}}
