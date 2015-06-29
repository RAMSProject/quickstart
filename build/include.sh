#!/bin/bash

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DOCKER_OPTS="-p 8282:8282 -v $CWD/../app:/mnt/app -v $CWD/uber-dev:/mnt/uber-dev"

# TODO: require 1.6 *OR HIGHER*
# right now this requires exactly 1.6
REQUIRE_DOCKER_VERSION="1.7"

if [ `docker --version | cut -f 3 -d ' ' | cut -f 1-2 -d '.'` != $REQUIRE_DOCKER_VERSION ]; then 
	echo "ERROR: you don't have the right version of docker ($REQUIRE_DOCKER_VERSION) installed! please upgrade (or fix this script)"
	exit -1
fi


