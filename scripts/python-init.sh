#!/bin/sh -eux

echo '----- install packages python3 -----'
pip3_install() {
    pip3 install --upgrade-strategy eager --progress-bar off --upgrade $1
    pip3 check $1
}

if [ `uname` == 'Darwin' ]; then
    # macOS only
    pip3_install pynvim
    exit 0
fi


pip3 install --upgrade pip

pip3_install aws-sam-cli
pip3_install awscli
pip3_install pynvim
