# 補完設定
autoload -U compinit
compinit

# 履歴の保存数
HISTSIZE=10000

# gitのファイ名補完を通常のファイル名補完と同じようにする
__git_files() { _files }

# 言語設定
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export lang=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# editor
export EDITOR=vim

# rbenv
eval "$(rbenv init -)"
#source ~/.rbenv/completions/rbenv.zsh

# PATHの設定
export PATH=/usr/local/bin:$PATH
export PATH=/usr/texbin:$PATH
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/MyScript

# PYTHON PATH
export PYTHONPATH="/usr/local/lib/python2.6/site-packages:$PYTHONPATH"

# 各種PATHの重複を除去する
typeset -U path cdpath fpath manpath

# ディレクトリスタックの重複を除去する
setopt PUSHD_IGNORE_DUPS 

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s|%b)'
zstyle ':vcs_info:*' actionformats '(%s|%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# プロンプトの表示フォーマット
PROMPT="%#"                      
RPROMPT="%1(v|%1v|)[%~]"         
setopt transient_rprompt            #右のパス名表示に入力が被るとパスを消す

# cd系のオプション
setopt auto_pushd                   #移動したディレクトリを記憶しておく。

#直前と同じコマンドを履歴に追加しない
setopt hist_ignore_dups

# 補完候補表示時にはビープを鳴らさない
setopt nolistbeep

# ベルは鳴らさない
setopt no_beep

# ^q,^s でフロー制御をしない
setopt no_flow_control

# エイリアス
alias emacs="emacs -nw"
alias encoding-utf8="nkf -wLu --overwrite"
alias tp="platex *.tex && platex *.tex && platex *.tex && dvipdfmx *.dvi && rm *.(dvi|aux|log|toc)"
alias tpo="platex *.tex && platex *.tex && platex *.tex && dvipdfmx *.dvi && rm *.(dvi|aux|log|toc) && open *.pdf"
alias pin="ping 8.8.8.8"
alias ipin="nslookup www.google.com"

#ptetex用の設定
export PTEX_IN_FILTER=/usr/local/bin/nkf
 
#Javaの実行時のメッセージをUTF-8に
alias javac='javac -J-Dfile.encoding=UTF8'
alias java='java -Dfile.encoding=UTF8' 
