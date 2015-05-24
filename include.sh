#!/bin/bash

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DOCKER_OPTS="-p 8282:8282 -v $CWD/app:/mnt/app"
