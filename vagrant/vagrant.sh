#!/bin/bash

# run ubersystem's docker installation in our VM.

# WIP. for now we do it by hand, but later might use DockerCompose
# or something similar to handle this.

# install docker (need latest version, not one with apt-get install docker.io)
wget -qO- https://get.docker.com/ | sh

cd /home/vagrant/docker

# build the docker container from scratch
./build-dev.sh
