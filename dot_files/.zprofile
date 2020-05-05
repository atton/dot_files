autoload -Uz compinit is-at-least

compinit -d $HOME/.config/zsh/zcompdump

# {{{ environment variables

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LIBRARY_PATH=/usr/local/lib:/usr/lib:$LIBRARY_PATH

if [ `uname` = 'Linux' ]; then
    export PATH=$HOME/.rbenv/bin:$PATH
fi

if which vi   >& /dev/null; then export EDITOR=vi;   fi
if which vim  >& /dev/null; then export EDITOR=vim;  fi
if which nvim >& /dev/null; then export EDITOR=nvim; fi

export APK_PROGRESS_CHAR='#'
export COOKIECUTTER_CONFIG=$HOME/.config/cookiecutter/cookiecutterrc
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
    zstyle ':vcs_info:*' enable git
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

function echo-and-eval()   { echo $1; eval "( $1 )"; }
function load-zprofile()   { if [ -f $1 ]; then source $1; fi }
function reload-zprofile() { source $HOME/.zprofile }

function shell-reinit() {
    autoload -Uz zmv
    if which rbenv  >& /dev/null; then eval "$(rbenv init - zsh)";  fi
    if which nodenv >& /dev/null; then eval "$(nodenv init - zsh)"; fi
    if [ `uname` = 'Darwin' ]; then load-zprofile $HOME/.config/zsh/zprofile.mac; fi
    typeset -U path
}

# }}}

# settings for specific command {{{

# AWS CLI
export AWS_CONFIG_FILE=$HOME/.config/aws/config
export AWS_DEFAULT_OUTPUT=yaml
export AWS_SHARED_CREDENTIALS_FILE=$HOME/.config/aws/credentials

# Git: disable git-based filename completion
__git_files() { _files }

# Node(nodenv)
if which nodenv >& /dev/null; then
    export PATH="$HOME/.nodenv/shims:${PATH}"
    export NODENV_SHELL=zsh
    source /usr/local/Cellar/nodenv/*/completions/nodenv.zsh
fi

# Ruby(rbenv)
if which rbenv >& /dev/null; then
    export PATH="$HOME/.rbenv/shims:${PATH}"
    export RBENV_SHELL=zsh
    source /usr/local/Cellar/rbenv/*/completions/rbenv.zsh
fi

# gem
export GEM_SPEC_CACHE=$HOME/.config/gem/specs
# ruby-build
export RUBY_CONFIGURE_OPTS="--enable-shared"
# bundler
export BUNDLE_USER_HOME=$HOME/.config/bundler

# }}}

#  {{{ load zprofiles

if [ `uname` = 'Darwin' ]; then load-zprofile $HOME/.config/zsh/zprofile.mac; fi
load-zprofile $HOME/.config/zsh/zprofile.local

# }}}

# {{{ end of setup

# uniquenize path
typeset -U path

# }}}
