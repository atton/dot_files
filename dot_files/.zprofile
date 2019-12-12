autoload -Uz compinit add-zsh-hook zmv is-at-least

compinit -d .config/zsh/zcompdump

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
    source $HOME/.config/zsh/zprofile.mac
else
    export PATH=$HOME/.rbenv/bin:$PATH
fi

export LESSHISTFILE=/dev/null

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
    source $HOME/.config/zsh/zprofile.util
    typeset -U path cdpath fpath manpath
}

function skk-cleanup-regexp() {
    echo "^[0-9a-z\u3042-\u3093\u30fc]*\\ \\/[0-9a-z\u3042-\u3093\u30fc]*\\/$"
}

# }}}

# settings for specific command {{{

# AWS
if which aws >& /dev/null; then
    export AWS_CONFIG_FILE=~/.config/aws/config
    export AWS_SHARED_CREDENTIALS_FILE=~/.config/aws/credentials
fi

# direnv
if which direnv >& /dev/null; then eval "$(direnv hook zsh)"; fi

# Git: not using git-based filename completion
__git_files() { _files }

# Mercurial
export HGENCODING=UTF-8

# Node(nodenv)
if which nodenv >& /dev/null; then eval "$(nodenv init - --no-rehash zsh)"; fi

# Ruby(rbenv)
if which rbenv >& /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi
# ruby-build
export RUBY_CONFIGURE_OPTS="--enable-shared"
# bundler
export BUNDLE_USER_HOME=~/.config/bundler

# }}}

#  {{{ source local zprofile
localzshrc=$HOME/.config/zsh/zprofile.local

if [ -f $localzshrc ]; then
    source $localzshrc
fi

# }}}
