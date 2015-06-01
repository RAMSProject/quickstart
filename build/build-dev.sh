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

echo "dev: creating dev docker container..."

docker run \
  --name intermediate_dev \
  $DOCKER_OPTS -t \
  magfest/uber-app /mnt/uber-dev/copy-code.sh

echo "dev: saving dev docker container..."

docker commit \
  -c "CMD /uber/env/bin/python3 /uber/sideboard/sideboard/run_server.py" \
  intermediate_dev magfest/uber-dev 

echo "dev: cleaining up intermediate containers..."

docker kill intermediate_dev
docker rm   intermediate_dev

echo "dev: all done!"
