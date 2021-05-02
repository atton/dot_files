#!/bin/bash

export GEM_SPEC_CACHE=$HOME/.config/gem/specs
export BUNDLE_USER_HOME=$HOME/.config/bundler

set -eux
type ruby gem
ruby --version
gem --version

set +eu
if type rbenv >& /dev/null; then rbenv rehash ; fi
gem update --no-document --system
gem install --no-document -f bundler
bundle install --gemfile "`dirname $0`/../Gemfile"
if type rbenv >& /dev/null; then rbenv rehash ; fi
