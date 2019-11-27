#!/bin/sh

echo '----- install packages python3 -----'
function pip3_install() {
    pip3 install --upgrade-strategy eager --progress-bar off --upgrade $1
    pip3 check $1
}

pip3_install pynvim
pip3_install awscli
pip3_install aws-sam-cli
