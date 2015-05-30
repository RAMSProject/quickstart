#!/bin/bash

set -e
. build/include.sh

# docker run $DOCKER_OPTS magfest/uberdev $1
docker-compose up
