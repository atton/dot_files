#!/bin/sh
cd `dirname $0`

mkdir -p ~/Library/KeyBindings
cp DefaultKeyBinding.dict ~/Library/KeyBindings

cp keymap.conf "$HOME/Library/Application Support/AquaSKK"
