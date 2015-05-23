#!/bin/bash

# copy the host user's SSH key to be accessible to the container
# needed to clone git repos non-interactively inside the docker container
#
# this SSH key should allow read-only access to any repos on github
# required to build this container
# cp ~/.ssh/id_rsa .

# run the rest of the build
docker build -t magfest/uber .
