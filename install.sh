#!/bin/sh
# dot files link script : files in dot_files link to $HOME

dir="dot_files"
target_dir=$HOME
files=`ls -1A $dir`

cd `dirname $0`
for file in $files
do
    command="ln -s `pwd`/${dir}/${file} ${target_dir}"
    echo $command
    $command
done
