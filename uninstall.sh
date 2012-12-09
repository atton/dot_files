#!/bin/sh
# unlink script : files in scripts unlink from /usr/local/bin

files=`ls -1A dot_files`
target_dir=$HOME

for file in $files
do
    command="rm -f ${target_dir}/${file}"
    echo $command
    $command
done
