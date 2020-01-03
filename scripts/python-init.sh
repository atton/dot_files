#!/bin/sh -eux

pip3_install() {
    pip3 install --upgrade-strategy eager --progress-bar off --upgrade $1
    pip3 check $1
}
which pip3

if [ `uname` == 'Darwin' ]; then pip3_install pynvim ; exit 0 ; fi


pip3 install --upgrade setuptools pip
pip3_install pynvim


if [ $# -eq 1 ]; then
    if [ $1 = 'NO_AWS' ]; then exit 0; fi
fi
pip3_install awscli
pip3_install aws-sam-cli
