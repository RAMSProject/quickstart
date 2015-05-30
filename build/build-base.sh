#!/bin/bash

. include.sh

# TODO: check if we already have a built base of this container somewhere.
# if so, use that instead of building it from scratch

# run the rest of the build
docker build -t magfest/uber-base uber-base
