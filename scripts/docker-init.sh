#!/bin/sh -eux

docker --version

docker pull alpine
docker pull centos

docker pull atton/latex-make
docker pull atton/webpage-title
