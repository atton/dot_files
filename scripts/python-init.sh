#!/bin/sh -eux

pip3_install() {
    pip3 install --upgrade-strategy eager --progress-bar off --upgrade $1
    pip3 check $1
}
which pip3

if [ `uname` == 'Darwin' ]; then pip3_install pynvim ; exit 0 ; fi


pip3 install --upgrade setuptools pip
pip3_install pynvim

pip3_install aws-sam-cli
pip3_install awscli
