autoload -Uz compinit add-zsh-hook zmv is-at-least

compinit

# {{{ environment variables

# languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# for tmuxinator
export EDITOR=nvim

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LIBRARY_PATH=/usr/local/lib:/usr/lib:$LIBRARY_PATH

# Path for specific environment
if [[  $(uname) == Darwin ]]; then
    source $HOME/.zprofile.mac
else
    export PATH=$HOME/.rbenv/bin:$PATH
fi

export LESSHISTFILE=$HOME/.config/less/history

# }}}

# options {{{
# emacs like key binding
bindkey -e

# number of history
HISTSIZE=10000

# delete duplicate histories
setopt extendedhistory
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histnostore
setopt histreduceblanks
setopt histverify

# delete duplicate path
typeset -U path cdpath fpath manpath

# disable beep
setopt nolistbeep
setopt no_beep

# disable flow control (disable ^q,^s)
setopt no_flow_control

# disable combine multi byte character on completion
setopt combining_chars

# prompt format
PROMPT="%m%# "                      # left prompt
RPROMPT="[%~]%1(v|%1v|)"            # right prompt
setopt transient_rprompt            # if typed chars conflict right prompt, hide right prompt

# vcs_info (zsh support vcs_info after 4.3.11)
if is-at-least 4.3.11; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git hg svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' unstagedstr   '+'
    zstyle ':vcs_info:*' formats       '%u(%s|%b)'
    zstyle ':vcs_info:*' actionformats '%u(%s|%b|%a)'
    precmd () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info >& /dev/null
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
fi

# }}}

# aliases {{{

alias pin="ping 8.8.8.8"
alias ipin="dig www.google.com"

alias be='bundle exec'
alias bet='RAILS_ENV=test bundle exec'
alias bep='RAILS_ENV=production bundle exec'

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

function echo_and_eval() {
    echo $1
    eval "( $1 )"
}

# Heavy initializations
function shell-init() {
    if which rbenv  >& /dev/null; then eval "$(rbenv init - zsh)";  fi
    if which nodenv >& /dev/null; then eval "$(nodenv init - zsh)"; fi
    if noir -v      >& /dev/null; then eval "$(noir init zsh)";     fi
    source $HOME/.zprofile.util
    typeset -U path cdpath fpath manpath
}

function skk-cleanup-regexp() {
    echo "^[0-9a-z\u3042-\u3093\u30fc]*\\ \\/[0-9a-z\u3042-\u3093\u30fc]*\\/$"
}

# }}}

# settings for specific command {{{

# Ruby
# initialize rbenv without rehash (rehash operation is heavy...)
if which rbenv >& /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi
# ruby-build
export RUBY_CONFIGURE_OPTS="--enable-shared"

# Node
if which nodenv >& /dev/null; then eval "$(nodenv init - --no-rehash zsh)"; fi

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

#  {{{ source local zprofile
localzshrc=$HOME/.zprofile.local

if [ -f $localzshrc ]; then
    source $localzshrc
fi

# }}}
