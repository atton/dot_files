#!/bin/sh
# dot files link script : files in dot_files link to $HOME
cd `dirname $0`

dir="dot_files"
target_dir=$HOME
files=`ls -1A $dir`

for file in $files
do
    command="ln -s `pwd`/${dir}/${file} ${target_dir}"
    echo $command
    $command
done

cp scripts/git-clone-github.sh /usr/local/bin/git-clone-github
cp scripts/git-clone-github-https.sh /usr/local/bin/git-clone-github-https


# macOS only
if [ `uname` != 'Darwin' ]; then exit 0; fi

mkdir -p ~/Library/KeyBindings
cp macOS/DefaultKeyBinding.dict ~/Library/KeyBindings

cp macOS/keymap.conf "$HOME/Library/Application Support/AquaSKK"
