#!/bin/sh -eux

if which nodenv >& /dev/null; then
    nodenv rehash
    prefix=$(nodenv prefix)
    echo "cache = $prefix/.npm" > "$prefix/lib/node_modules/npm/npmrc"
fi

# $ npm ls -g --depth=0
# get installed package information
npm install -g neovim
npm install -g npm
npm install -g typescript
npm install -g yarn
if which nodenv >& /dev/null; then nodenv rehash ; fi
