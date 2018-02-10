#!/bin/bash

set -uxe
DOCKER_PREFIX=nandi108

dir=$1
image="$DOCKER_PREFIX/$(basename $dir)"
time sudo docker build -t $image $dir
time sudo docker push $image
