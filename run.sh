#!/bin/bash

. include.sh

docker run --name uberapp $DOCKER_OPTS -it magfest/uberdev $1
