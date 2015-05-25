#!/bin/bash

# run ubersystem's docker installation in our VM.

# WIP. for now we do it by hand, but later might use DockerCompose
# or something similar to handle this.

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

# install docker (need latest version, not one with apt-get install docker.io)
if command_exists docker || command_exists lxc-docker; then
	echo "Docker command already exists, skipping docker install"
else
	wget -qO- https://get.docker.com/ | sh
fi

cd /home/vagrant/docker

# build the docker container from scratch
./build-dev.sh
