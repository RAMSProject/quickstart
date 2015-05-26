super mega early beta of ubersystem running in a container
ULTRA EXPERIMENTAL RIGHT NOW
-Dom

for production do this:

```
./build.sh
```

then

```
docker-compose up
```
(run with whatever options you like)

Which runs the actual container (you will also need to start a DB/etc)

----------------------

for dev environments (with Vagrant) do this:

```
vagrant up
# wait 30 minutes for everything to build
vagrant ssh
```

then

```
cd docker
docker-compose up
```

This will start the uber app in a container, and the code will be accessible from the OS running Vagrant (i.e. Windows) in app/uber/

Open your brower and go to "http://localhost:8282/magfgest"

---------------

More details:
====

What is build-dev.sh doing?

This will take the uber base image and copy all the python code from 
the docker container's /uber into the data volume. 
This is mounted from the host OS in the 'app' directory here.  You can now
edit the code there with your favorite editor/IDE

The command then setups ubersystem to run with the code in the volume.

It will also save a new image called 'magfest/uberdev' which you can now run.
This image is identical to 'magfest/uber' which was just built, except,
it will look for it's code in the 'app/uber' directory, making it nice for
development.

The entire point of this is the host OS can access the data volume and 
edit the running code inside the docker container.

DO NOT USE THIS IN PRODUCTION. However, it's very useful in development.

ONLY RUN THIS SCRIPT ONCE or it will overwrite your code changes with the
stock code inside the container.

-----------

ULTRA EXPERIMENTAL, can't stress that enough.  Also there's a bunch of dumb
things we should fix in here.  Dom and Thaeli are on it.
