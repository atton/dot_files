#!/bin/sh

branch=`git branch | grep '*' | awk '{print $2}'`
git branch --set-upstream-to=origin/${branch} ${branch}
git pull
