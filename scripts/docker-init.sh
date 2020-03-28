#!/bin/sh -eux
cd `dirname $0`

docker pull alpine
docker pull centos
docker pull ruby:2.5.7-alpine
docker pull ruby:2.7.0-alpine
