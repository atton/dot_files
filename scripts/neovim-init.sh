#!/bin/sh
cd `dirname $0`

dependencies='nvim curl git sh'
for cmd in $dependencies ; do
    which $cmd >& /dev/null
    if [ $? -ne 0 ]; then
        echo "$cmd is missing. abort."
        echo "$0 needs ${dependencies}."
        exit 1
    fi
done

set -x

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh ~/.config/nvim/dein
rm /tmp/installer.sh

mkdir -p ~/.config/nvim/eskk
curl https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L > ~/.config/nvim/eskk/SKK-JISYO.L

nvim -c ':call dein#install()' -c ':UpdateRemotePlugins' -c ':quit'
