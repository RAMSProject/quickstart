Docker container code folder sharing
====

What is build-dev.sh doing?

This will take the uber base image and copy all the python code from 
the docker container's /uber into the data volume. 
This is mounted from the host OS in the 'app' directory here.  You can now
edit the code there with your favorite editor/IDE

The command then setups ubersystem to run with the code in the volume.

It will also save a new image called 'magfest/uber-dev' which you can now run.
This image is identical to 'magfest/uber-app' which was just built, except,
it will look for it's code in the 'app/uber' directory, making it nice for
development.

The entire point of this is the host OS can access the data volume and 
edit the running code inside the docker container.

DO NOT USE THIS IN PRODUCTION. However, it's very useful in development.

ONLY RUN THIS SCRIPT ONCE or it will overwrite your code changes with the
stock code inside the container.