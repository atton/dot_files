#!/bin/sh

pip3_install() {
    pip3 install --no-color --progress-bar off --upgrade $@
    pip3 check $@
}

set -eux
python3 -V
pip3 --version

pip3 install --quiet --upgrade setuptools pip
pip3 check setuptools pip
pip3 --version
pip3_install msgpack pynvim
