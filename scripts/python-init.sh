#!/bin/sh

echo '----- install packages python3 -----'
function pip3_install() {
    pip3 install --upgrade-strategy eager --progress-bar off --upgrade $1
    if [ $? -ne 0 ]; then
        pip3 install --upgrade-strategy eager --upgrade $1
    fi

    pip3 check $1
}

pip3_install pynvim

# not macOS only
if [ `uname` == 'Darwin' ]; then exit 0; fi

pip3_install awscli
pip3_install aws-sam-cli
