#!/bin/sh
# dot files unlink script : unlink dot files from $HOME
cd `dirname $0`

files=`ls -1A dot_files`
target_dir=$HOME

set -x
for file in $files
do
    rm -f ${target_dir}/${file}
done

rm /usr/local/bin/git-pull-with-set-upstream-to-origin

# macOS only
if [ `uname` != 'Darwin' ]; then exit 0; fi

rm ~/Library/KeyBindings/DefaultKeyBinding.dict
rmdir ~/Library/KeyBindings

rm "$HOME/Library/Application Support/AquaSKK/keymap.conf"
