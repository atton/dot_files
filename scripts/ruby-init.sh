#!/bin/sh
cd `dirname $0`

echo ---------- ruby, gem versions ----------
ruby -v
gem -v
echo ---------- initializations ----------
gem update --system
gem install bundler
cp ../Gemfile .
bundle install
rm Gemfile*
