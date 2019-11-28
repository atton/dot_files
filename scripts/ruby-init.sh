#!/bin/sh

if which rbenv >& /dev/null; then rbenv rehash ; fi
echo ------------- versions -------------
echo "ruby: `ruby -v`"
echo "gem:  `gem -v`"
echo ---------- initializations ----------
if [ -f Gemfile ]; then echo 'Gemfile detected, abort.'; exit 1; fi
if [ -f Gemfile.lock ]; then echo 'Gemfile.lock detected, abort.'; exit 1; fi
set -x
gem update --system
gem install -f bundler
cp `dirname $0`/../Gemfile .
bundle install
rm Gemfile*
if which rbenv >& /dev/null; then rbenv rehash ; fi
