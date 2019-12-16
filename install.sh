#!/bin/sh
# dot files link script : files in dot_files link to $HOME
cd `dirname $0`

dir="dot_files"
target_dir=$HOME
files=`ls -1A $dir`
current_dir=`pwd`

set -x
for file in $files
do
    ln -s ${current_dir}/${dir}/${file} ${target_dir}
done

cp scripts/git/git-pull-with-set-upstream-to-origin.sh /usr/local/bin/git-pull-with-set-upstream-to-origin

# macOS only
if [ `uname` != 'Darwin' ]; then exit 0; fi

mkdir -p ~/Library/KeyBindings
cp macOS/DefaultKeyBinding.dict ~/Library/KeyBindings

cp macOS/keymap.conf "$HOME/Library/Application Support/AquaSKK"
