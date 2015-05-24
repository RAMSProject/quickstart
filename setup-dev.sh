#!/bin/bash
#
# DEVELOPMENT ONLY!
#
# copy the code inside the docker container into a mounted volume, 
# this way the developer can access it from outside of the docker
# container (i.e. in an IDE or similar)

# entire script exits if any part errors out
set -e 

. include.sh

# docker kill intermediate_dev
# docker rm   intermediate_dev

# echo $DOCKER_OPTS

docker run --name intermediate_dev $DOCKER_OPTS -it magfest/uber /mnt/app/copy-code.sh

docker commit intermediate_dev magfest/uberdev

docker kill intermediate_dev
docker rm   intermediate_dev

./run.sh "/uber/env/bin/python3 /uber/sideboard/run_server.py"
