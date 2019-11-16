#!/bin/sh

echo '----- install pynvim (use pip2, pip3) -----'
pip2 install --upgrade-strategy eager --progress-bar off --upgrade pynvim
pip3 install --upgrade-strategy eager --progress-bar off --upgrade pynvim

echo '----- check pynvim (use pip2, pip3) -----'
pip2 check pynvim
pip3 check pynvim
