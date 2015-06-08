#!/bin/bash

# run ubersystem's docker installation in our VM.
cd /home/vagrant/docker

# install anything this host needs to run docker containers and do builds
setup/setup.sh

# build the docker container from scratch, and then modify it for development
# so that the code is exposed in app/uber/
build/build.sh

# windows-only: tell all git repos to ignore file permissions, which are 
# broken on vagrant shared folders from windows. (doesn't affect *nix)
vagrant/set-git-ignore-permissions.sh

# setup some bash aliases/etc
cp vagrant/bashrc /home/vagrant/.bash_aliases
