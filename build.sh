#!/bin/bash

# copy the host user's SSH key to be accessible to the container
# needed to clone git repos non-interactively inside the docker container
#
# this SSH key should allow read-only access to any repos on github
# required to build this container
# cp ~/.ssh/id_rsa .

REQUIRE_DOCKER_VERSION="1.6"

if [ `docker --version | cut -f 3 -d ' ' | cut -f 1-2 -d '.'` != $REQUIRE_DOCKER_VERSION ]; then 
	echo "ERROR: you don't have the right version of docker ($REQUIRE_DOCKER_VERSION) installed! please upgrade (or fix this script)"
	exit -1
fi

# run the rest of the build
docker build -t magfest/uber context
