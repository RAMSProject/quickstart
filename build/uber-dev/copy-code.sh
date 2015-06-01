#!/bin/bash
# Don't run this script directly, it's part of another script.
# DEVELOPMENT ONLY - NEVER USE IN PRODUCTION
#
# since we can't easily share dirs FROM the container TO the host,
# we'll do the following:  Copy the code deployed inside the Docker container
# TO THE DATA VOLUME, so the external host (developer) can access it.
#
# Once the docker container is fully setup,
# run this script FROM INSIDE THE CONTAINER

echo "DEVELOPMENT ONLY: Copying code into data volume so you can edit it..."
mv /uber /mnt/app/
ln -s /mnt/app/uber /uber


# part 2, optional: if PyCharm debugger egg is present, go ahead and install it so
# that pycharm users can do debugging. follow instructions in the Readme

if [ -e /mnt/app/pycharm-debug-py3k.egg ]
then
    echo "DEVELOPMENT ONLY: detected PyCharm egg, installing debugger support"
    /uber/env/bin/easy_install /mnt/app/pycharm-debug-py3k.egg
fi