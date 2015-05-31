#!/bin/bash

# installs latest docker and docker-compose

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

# allow us to run docker without sudo
groupadd docker
usermod -aG docker vagrant

# install docker (need latest version, not one with apt-get install docker.io)
if command_exists docker || command_exists lxc-docker; then
	echo "Docker command already exists, skipping docker install"
else
	wget -qO- https://get.docker.com/ | sh
fi

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

