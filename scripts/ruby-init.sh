#!/bin/sh -eux

export GEM_SPEC_CACHE=$HOME/.config/gem/specs
export BUNDLE_USER_HOME=$HOME/.config/bundler
which ruby
which gem
set +eu

if which rbenv >& /dev/null; then rbenv rehash ; fi
gem update --no-document --system
gem install --no-document -f bundler
bundle install --gemfile "`dirname $0`/../Gemfile"
if which rbenv >& /dev/null; then rbenv rehash ; fi
