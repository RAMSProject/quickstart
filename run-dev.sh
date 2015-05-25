#!/bin/bash

set -e
. include.sh

docker run $DOCKER_OPTS magfest/uberdev $1
