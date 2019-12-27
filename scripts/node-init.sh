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
    npm install -g npm

    npm install -g neovim
    npm install -g typescript
    npm install -g yarn
    # $ npm ls -g --depth=0 # get installed packages information
}

which nodenv >& /dev/null;
check_nodenv=$?

set -eux

which node
which npm

if [ $check_nodenv -eq 0 ]; then
    nodenv_before_install
    install_packages
    nodenv_after_install
else
    install_packages
fi
