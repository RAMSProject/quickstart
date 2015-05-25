#!/bin/bash

# run ubersystem's docker installation in our VM.

# WIP. for now we do it by hand, but later might use DockerCompose
# or something similar to handle this.

cd /home/vagrant/docker

# build the docker container from scratch
./build.sh

# modify it suitable for development
./setup-dev.sh
