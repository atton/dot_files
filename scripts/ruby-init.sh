#!/bin/bash

export GEM_SPEC_CACHE=$HOME/.config/gem/specs
export BUNDLE_USER_HOME=$HOME/.config/bundler

set -eux
ruby --version
gem --version

set +eu
if which rbenv >& /dev/null; then rbenv rehash ; fi
gem update --no-document --system
gem install --no-document -f bundler
bundle install --gemfile "`dirname $0`/../Gemfile"
if which rbenv >& /dev/null; then rbenv rehash ; fi

set -eu
gem --version
kramdown --version
neovim-ruby-host --version
pry --version
