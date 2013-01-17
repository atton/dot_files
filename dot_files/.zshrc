# complete enable
autoload -U compinit
compinit

# file completion in git command, use normal completion
__git_files() { _files }

# languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# editor
export EDITOR=vim

# PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/texbin:$PATH
export PATH=$PATH:$HOME/.cabal/bin

# Ruby
# rbenv
rbenv >& /dev/null
if [ $? -eq 0 ]; then
    eval "$(rbenv init -)"
fi

# PYTHON PATH
export PYTHONPATH="/usr/local/lib/python2.6/site-packages:$PYTHONPATH"

# Java CLASSPATH
# add javafx jar file in classpath on Mac(jdk1.7)
export CLASSPATH=$CLASSPATH:`/usr/libexec/java_home`/jre/lib/jfxrt.jar

# settings
# number of history
HISTSIZE=10000

# delete duplicate path
typeset -U path cdpath fpath manpath

# ignore current directory when 'cd ..' completion
zstyle ':completion:*' ignore-parents parent pwd ..

# delete duplicate directory in directory stack
setopt PUSHD_IGNORE_DUPS

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

# prompt format
PROMPT="%#"                         # left prompt
RPROMPT="[%~]%1(v|%1v|)"            # right prompt
setopt transient_rprompt            # if typed chars conflict right prompt, hide right prompt


# if type command already added in history, not add in history
setopt hist_ignore_dups

# beep disable in list completion
setopt nolistbeep

# beep disable
setopt no_beep

# disable flow control (disable ^q,^s)
setopt no_flow_control

# aliases
alias tp="platex *.tex && platex *.tex && platex *.tex && dvipdfmx *.dvi && rm *.(dvi|aux|log|toc)"
alias tpo="platex *.tex && platex *.tex && platex *.tex && dvipdfmx *.dvi && rm *.(dvi|aux|log|toc) && open *.pdf"
alias pin="ping 8.8.8.8"
alias ipin="nslookup www.google.com"

# alias for Java (set encoding)
alias javac='javac -J-Dfile.encoding=UTF8'
alias java='java -Dfile.encoding=UTF8'

# custom cd
function cd() {
    if [ $# -eq 0 ]; then
        # if have no arguments, pushd $HOME
        builtin pushd $HOME
    else
        # if have arguments, builtin cd
        builtin cd $@
    fi
}
