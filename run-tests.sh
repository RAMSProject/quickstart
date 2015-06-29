#!/bin/bash
# run all of sideboard's / uber's unit tests in a new container

docker run -v /home/vagrant/docker/app:/mnt/app \
  -ti \
  -w /uber/sideboard \
  magfest/uber-dev \
  /uber/sideboard/run-tests.sh