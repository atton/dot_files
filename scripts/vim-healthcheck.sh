#!/bin/sh -eux

test -f $HOME/.vimrc
vim --version
vim -es -u NONE -c 'try | source $HOME/.vimrc | catch | cquit! | endtry | quit!'
vim +'if exists(":SudoWriteCurrentBuffer") | quit! | else | cquit! | endif'
