#!/bin/sh -eux

pip3_install() {
    pip3 install --no-color --progress-bar off --upgrade $@
    pip3 check $@
}
pip3 --version

pip3 install --upgrade setuptools pip
pip3 check setuptools pip
pip3_install pynvim

if [ $# -eq 1 ]; then if [ $1 = 'NO_AWS' ]; then exit 0; fi fi
pip3_install awscli aws-sam-cli
