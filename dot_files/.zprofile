autoload -Uz compinit add-zsh-hook zmv is-at-least

compinit -d .config/zsh/zcompdump

# {{{ environment variables

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LIBRARY_PATH=/usr/local/lib:/usr/lib:$LIBRARY_PATH

if [[ $(uname) == Darwin ]]; then
    source $HOME/.config/zsh/zprofile.mac
else
    export PATH=$HOME/.rbenv/bin:$PATH
    export APK_PROGRESS_CHAR='#'
fi

if which vi   >& /dev/null; then export EDITOR=vi;   fi
if which vim  >& /dev/null; then export EDITOR=vim;  fi
if which nvim >& /dev/null; then export EDITOR=nvim; fi

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
        if [ -x new_note.sh ]; then ./new_note.sh > $name; fi
        $EDITOR $name
    fi
}

function note-calc-times() {
    local basepath=/tmp/note-calc-times
    mkdir -p $basepath

    local filespath="$basepath/files"
    ls -1 $@ |& egrep -v '[^0-9]:' > $filespath

    local timeregexp='^[0-9/]{10} [0-9:]{8}$'
    local timespath="$basepath/times"
    cat $filespath | xargs cat |& egrep -v '^cat:' | egrep $timeregexp | sort > $timespath

    local size=$((`cat $timespath | wc -l`))
    if [ $size  -eq 0 ]; then
        echo 'formatted time not detected. abort.'
        return 1
    elif [ $(($size % 2)) -eq 1 ]; then
        echo "detected time $size counts, not-even. abort."
        return 1
    fi
    function line() { printf "%55s\n" | tr ' ' '-' }
    line; echo "detected time $size counts. listing..."; line
    cat $filespath | xargs egrep -Hn $timeregexp
    line; echo 'formatted time calculating...' ; line

    function to_unixtime() {
        if [ `uname` = 'Darwin' ]; then
            date -j -u -f '%Y/%m/%d %H:%M:%S' "$1" '+%s'
        elif which busybox >& /dev/null; then
            date -D '%Y/%m/%d %H:%M:%S' -d "$1" '+%s'
        else
            date -d "$1" '+%s' # Maybe GNU Linux
        fi
    }
    function print_time() {
        local hour=$(($2 / 3600))
        local minute=$((($2 % 3600) / 60))
        local second=$(($2 % 60))
        printf "$1%02d:%02d:%02d\n" $hour $minute $second
    }
    function calc_time_diff() {
        local before=`to_unixtime $1`
        local after=`to_unixtime $2`
        local diff=$(($after - $before))

        print_time "$1 -> $2 = " $diff
        total=$(($total + $diff))
    }

    declare -a lines; lines=( "${(@f)"$(<$timespath)"}" )
    local total=0
    local i=1
    while true ; do
        local i1=$(($i+1))
        if [ $i1 -gt $size ]; then break; fi

        calc_time_diff ${lines[$i]} ${lines[$i1]}
        i=$(($i+2))
    done
    line; print_time 'Total time: ' $total

    unfunction line to_unixtime print_time calc_time_diff
    rm -rf $basepath
}

function shell-reinit() {
    # *env initializations with rehash and load utils
    if which rbenv  >& /dev/null; then eval "$(rbenv init - zsh)";  fi
    if which nodenv >& /dev/null; then eval "$(nodenv init - zsh)"; fi
    source $HOME/.config/zsh/zprofile.util
    typeset -U path cdpath fpath manpath
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

# Node(nodenv)
if which nodenv >& /dev/null; then eval "$(nodenv init - --no-rehash zsh)"; fi

# Ruby(rbenv)
if which rbenv >& /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi
# gem
export GEM_SPEC_CACHE=$HOME/.config/gem/specs
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
