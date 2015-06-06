# complete enable
autoload -U compinit add-zsh-hook zmv
compinit

# {{{ environment variables

# languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# for tmuxinator
export EDITOR=vim
export SHELL=zsh

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


# for my util function
export LOOP_EXEC_MAX_COUNT=50
export CAREFUL_SYNC_OPTS='--exclude=".*"'

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
setopt PUSHD_IGNORE_DUPS

# beep disable in list completion
setopt nolistbeep

# beep disable
setopt no_beep

# disable flow control (disable ^q,^s)
setopt no_flow_control

# ignore current directory when 'cd ..' completion
zstyle ':completion:*' ignore-parents parent pwd ..

# prompt format
PROMPT="%m%# "                      # left prompt
RPROMPT="[%~]%1(v|%1v|)"            # right prompt
setopt transient_rprompt            # if typed chars conflict right prompt, hide right prompt

# vcs_info (zsh support vcs_info after 4.3.11)
autoload -Uz is-at-least
if is-at-least 4.3.11; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' formats '(%s|%b)'
    zstyle ':vcs_info:*' actionformats '(%s|%b|%a)'
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
alias bes='bundle exec rails server'
alias bec='bundle exec rails console'
alias bet='RAILS_ENV=test bundle exec'
alias bep='RAILS_ENV=production bundle exec'

alias wine='LC_ALL=ja_JP.UTF-8 wine'

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

function _loop_exec()
{
    if [ $# -ne 2 ]; then
        echo 'invalid argument. do not call this function by user'
        return 1
    fi

    if [ $2 -gt $LOOP_EXEC_MAX_COUNT ]; then
        echo "loop_exec was executed \"${1}\" ${LOOP_EXEC_MAX_COUNT} times. exit."
        return 1
    fi

    eval "$1"

    if [ $? -ne 0 ]; then
        echo "exit status was not 0. retry command... ($2)"
        _loop_exec "$1" $(expr $2 + 1)
    fi
}

function loop_exec() {
    if [ $# -ne 1 ]; then
        echo 'Usage : loop_exec {loop_exec_command}'
        echo 'argument must be single. if command has argument, please quote.'
        return 1
    fi

    _loop_exec "$1" 1
}

function careful_sync {
    if [ $# -lt 2 -o $# -gt 3 ]; then
        echo 'Usage : careful_sync <rsync-additional-opts> <source-dir> <destination-dir>'
        return 1
    fi

    if [ $# -eq 2 ]; then
        rsync_opts=''
        source=$1
        destination=$2
    elif [ $# -eq 3 ]; then
        rsync_opts=$1
        source=$2
        destination=$3
    fi


    loop_exec "rsync -avx  ${CAREFUL_SYNC_OPTS} ${rsync_opts} '${source}' '${destination}'"

    if [ $? -ne 0 ]; then
        echo 'Failed synchronization without checksum validation. Validation skipped.'
        return 1
    fi
    loop_exec "rsync -acvx ${CAREFUL_SYNC_OPTS} ${rsync_opts} '${source}' '${destination}'"
}

function compress_directory() {
    rar a -r -rr5 $1.rar $1
}

function archive_directory() {
    find . -name '*.db' -print0 | xargs -0 rm
    find . -name '.*'   -print0 | xargs -0 rm
    find . -name '_*'   -print0 | xargs -0 rm

    for dir in *; do
        compress_directory "$dir" && rm -rf "$dir"
    done
}

# }}}

# settings for specific command {{{

# Ruby
# rbenv
if which rbenv >& /dev/null; then eval "$(rbenv init - zsh)"; fi
# noir
if noir -v >& /dev/null; then eval "$(noir init zsh)"; fi
# ruby-build
export RUBY_CONFIGURE_OPTS="--enable-shared"

# Python
# pyenv
if which pyenv >& /dev/null; then
    eval "$(pyenv init - zsh)"
    alias brew='env PATH=${PATH/$HOME\/.pyenv\/shims:/} brew'
fi

# Java
# Java CLASSPATH
# add javafx jar file in classpath on Mac(jdk1.7)
if [[  $(uname) == Darwin ]]; then
    export CLASSPATH=$CLASSPATH:`/usr/libexec/java_home`/jre/lib/jfxrt.jar
fi
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

# docker (for OSX)
if which boot2docker >& /dev/null; then eval "$(boot2docker shellinit > /dev/stdout >& /dev/null)"; fi


# }}}

# {{{ notification settings in Mac

function init_notifier() {
    if ! [[ $(uname) == Darwin ]]; then return; fi

    notify_script_path="$HOME/.zsh.d/zsh-notify/notify.plugin.zsh"
    notifier_command="terminal-notifier"

    if ! [ -f $notify_script_path ]; then return; fi
    if ! (which $notifier_command >& /dev/null) ; then return; fi

    source $notify_script_path
    export SYS_NOTIFIER=`which $notifier_command`
    export NOTIFY_COMMAND_COMPLETE_TIMEOUT=10
}

init_notifier

# }}}

#  {{{ source local zshrc
localzshrc=$HOME/.zshrc.local

if [ -f $localzshrc ]; then
    source $localzshrc
fi

# }}}
