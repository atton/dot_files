#!/bin/sh
cd `dirname $0`

mkdir -p ~/Library/KeyBindings
cp DefaultKeyBinding.dict ~/Library/KeyBindings

cp keymap.conf "$HOME/Library/Application Support/AquaSKK"

cp git-clone-github.sh /usr/local/bin/git-clone-github
cp git-clone-github-https.sh /usr/local/bin/git-clone-github-https
