#!/bin/sh
cd `dirname $0`

set -eux

which nvim curl git sh pip3 gcc
./python-init.sh 'NO_AWS'

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh ~/.config/nvim/dein
rm /tmp/installer.sh

mkdir -p ~/.config/nvim/eskk
curl https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L > ~/.config/nvim/eskk/SKK-JISYO.L

nvim -c ':call dein#install()' -c ':UpdateRemotePlugins' -c ':quit'
