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

docker run \
  --name intermediate_dev \
  $DOCKER_OPTS -t \
  magfest/uber-app /mnt/uber-dev/copy-code.sh

docker commit \
  -c "CMD /env/bin/python3 /uber/sideboard/run_server.py" \
  intermediate_dev magfest/uber-dev 

docker kill intermediate_dev
docker rm   intermediate_dev
