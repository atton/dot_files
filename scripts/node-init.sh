#!/bin/sh

nodenv_before_install() {
    nodenv rehash
    prefix=$(nodenv prefix)
    echo "cache = $prefix/.npm" > "$prefix/lib/node_modules/npm/npmrc"
}

nodenv_after_install() {
    nodenv rehash
}

install_packages() {
    npm update -g npm
    npm install -g neovim serverless yarn
}

which nodenv >& /dev/null;
check_nodenv=$?

set -eux

node --version
npm --version

if [ $check_nodenv -eq 0 ]; then
    nodenv_before_install
    install_packages
    nodenv_after_install
else
    install_packages
fi

neovim-node-host --version
npm --version
sls --version
yarn --version
