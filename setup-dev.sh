#!/bin/bash
# copy the code inside the docker container into a mounted volume, 
# this way the developer can access it from outside of the docker
# container (i.e. in an IDE or similar)

./run.sh dev/copy-code.sh
