autoload -Uz compinit zmv is-at-least

compinit -d .config/zsh/zcompdump

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

function echo-and-eval() { echo $1; eval "( $1 )"; }
function load-zprofile() { if [ -f $1 ]; then source $1; fi }
function unique-paths()  { typeset -U path cdpath fpath manpath }

function note() {
    local serial_number=`ls -1 | egrep '[0-9]+_.{8}.txt' | wc -l`

    if [ $# -ge 1 -a $1 -le 0 ] >& /dev/null; then
        local serial=`printf '%02d' $(($serial_number $1))`
        $EDITOR ${serial}_????????.txt
        return $?
    fi

    local today=`date +%Y%m%d`
    ls -1 | egrep "[0-9]+_${today}.txt" >& /dev/null
    if [ $? -eq 0 ]; then
        $EDITOR *_${today}.txt
    else
        local serial=`printf '%02d' $(($serial_number + 1))`
        local name=${serial}_${today}.txt
        if [ -x new-note.sh ]; then ./new-note.sh > $name; fi
        $EDITOR $name
    fi
}

function shell-reinit() {
    # *env initializations with rehash and load utils
    if which rbenv  >& /dev/null; then eval "$(rbenv init - zsh)";  fi
    if which nodenv >& /dev/null; then eval "$(nodenv init - zsh)"; fi
    if [ `uname` = 'Darwin' ]; then load-zprofile $HOME/.config/zsh/zprofile.mac; fi
    load-zprofile $HOME/.config/zsh/zprofile.util
    # unique-paths
}

# }}}

# settings for specific command {{{

# AWS
if which aws >& /dev/null; then
    export AWS_CONFIG_FILE=$HOME/.config/aws/config
    export AWS_SHARED_CREDENTIALS_FILE=$HOME/.config/aws/credentials
fi

# Git: not using git-based filename completion
__git_files() { _files }

# Node(nodenv)
if which nodenv >& /dev/null; then eval "$(nodenv init - --no-rehash zsh)"; fi

# Ruby(rbenv)
if which rbenv >& /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi
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
unique-paths

# }}}
