#!/bin/bash
#
# FOR DEVELOPMENT ONLY! NEVER USE IN PRODUCTON!
#
# copy the code inside the docker container into a mounted volume, 
# this way the developer can access it from outside of the docker
# container (i.e. in an IDE or similar)

# entire script exits if any part errors out
set -e 

. include.sh

./build.sh

docker run \
  --name intermediate_dev \
  $DOCKER_OPTS -it \
  magfest/uber /mnt/app/copy-code.sh

docker commit \
  -c "CMD /uber/env/bin/python3 /uber/sideboard/run_server.py" \
  intermediate_dev magfest/uberdev 

docker kill intermediate_dev
docker rm   intermediate_dev
