#!/bin/sh
cd `dirname $0`

rm ~/Library/KeyBindings/DefaultKeyBinding.dict
rmdir ~/Library/KeyBindings

rm "$HOME/Library/Application Support/AquaSKK/keymap.conf"
