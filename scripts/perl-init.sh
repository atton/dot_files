#!/bin/sh -eux
cd `dirname $0`

perl --version
cpanm -version

cpanm -nq Neovim::Ext
