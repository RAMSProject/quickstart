#!/bin/bash

set -e
. build/include.sh

docker exec -ti docker_web_1 $1
# docker-compose up
