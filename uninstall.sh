#!/bin/sh
cd `dirname $0`

files=`ls -1A dot_files`
target_dir=$HOME

set -x
for file in $files
do
    rm -f ${target_dir}/${file}
done


if [ `uname` != 'Darwin' ]; then exit 0; fi
# macOS only configrations

rm -f ~/Library/KeyBindings/DefaultKeyBinding.dict
rmdir ~/Library/KeyBindings

rm -f "$HOME/Library/Application Support/AquaSKK/keymap.conf"
