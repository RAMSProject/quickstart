#!/bin/bash

. include.sh

docker run --name uberapp $DOCKER_OPTS -dt magfest/uberdev $1
