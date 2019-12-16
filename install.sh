#!/bin/sh
cd `dirname $0`

dir="dot_files"
target_dir=$HOME
files=`ls -1A $dir`
current_dir=`pwd`

set -x
for file in $files
do
    ln -sf ${current_dir}/${dir}/${file} ${target_dir}
done

cp scripts/git/git-pull-with-set-upstream-to-origin.sh /usr/local/bin/git-pull-with-set-upstream-to-origin


if [ `uname` != 'Darwin' ]; then exit 0; fi
# macOS only configrations

mkdir -p ~/Library/KeyBindings
cp macOS/DefaultKeyBinding.dict ~/Library/KeyBindings

cp macOS/keymap.conf "$HOME/Library/Application Support/AquaSKK"
