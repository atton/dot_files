#!/bin/sh
# dot files unlink script : unlink dot files from $HOME

files=`ls -1A dot_files`
target_dir=$HOME

for file in $files
do
    target=${target_dir}/${file} 

    if [ -L $target ]; then 
        # if exists as symlink
        command="rm -f $target"
    elif [ -e $target ]; then
        # if exists not symlink
        command="mkdir -p backup && mv ${target} backup"
    fi

    echo $command
    $command
done
