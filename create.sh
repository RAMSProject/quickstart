#!/bin/bash

set -e
. include.sh

docker create --name uberapp $DOCKER_OPTS magfest/uberdev $1
