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

alias grep-url='egrep -o "https?://[^ ]+"'
alias pin="ping 8.8.8.8"

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
    load-zprofile $HOME/.config/zsh/zprofile.local
    typeset -U path
}

# }}}

# settings for specific command {{{

# AWS CLI
export AWS_CONFIG_FILE=$HOME/.config/aws/config
export AWS_DEFAULT_OUTPUT=yaml
export AWS_SHARED_CREDENTIALS_FILE=$HOME/.config/aws/credentials

# Docker
if which docker >& /dev/null; then
    function docker-run-latest-sandbox() {
        if [ -z "$(docker ps -q --filter "name=${1}")" ]; then
            docker run --rm -it --name ${1} ${1} ${2}
        else
            docker run --rm -it ${1} ${2}
        fi
    }
    alias alpine='docker-run-latest-sandbox alpine'
    alias centos='docker-run-latest-sandbox centos'
    alias docker-volumes-cleanup='docker volume ls --quiet | egrep "[0-9a-f]{64}" | xargs docker volume rm'
fi

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

# {{{ settings for mac

if [ `uname` = 'Darwin' ]; then
    export CP_HOME_DIR=$HOME/.config/cocoapods
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_EMOJI=1
    export RUBY_CONFIGURE_OPTS="--enable-shared --with-openssl-dir=/usr/local/opt/openssl@1.1"
    # "brew --prefix openssl@1.1" is heavy. So set "--with-openssl-dir" directly. (More info: $ brew info ruby-build)

    alias docker-hypervisor='docker run -it --rm --privileged --pid=host alpine'
    alias dsnow='pmset displaysleepnow'
    alias hubb='hub browse'
    alias hubc='hub ci-status -v'
    alias hubco='hub ci-status -v | grep-url | xargs open -a safari'
    alias notification-banner-clear='terminal-notifier -remove ALL'
    alias work='tmuxinator work'
fi

# }}}

# {{{ load local zprofile

load-zprofile $HOME/.config/zsh/zprofile.local

# }}}

# {{{ end of setup

# uniquenize path
typeset -U path

# }}}
