super mega early beta of ubersystem running in a container
ULTRA EXPERIMENTAL RIGHT NOW
-Dom

OH HEY I CHANGED EVERYTHING AGAIN EVEN MORE EXPERIMENTAL EDITION
(now with 100% less Vagrant)
-Thaeli

To get a basic copy of RAMS up and running:
===
```
docker-compose up -d
```
Then browse to http://localhost:8282/uber - if you're using boot2docker you may need to use the IP address from `boot2docker ip` instead of localhost.


Whoa, back up a bit! How do I get this Docker thing running?
===
Docker has very comprehensive install docs: https://docs.docker.com/installation/#installation
You may also need to install docker-compose separately.

https://registry.hub.docker.com/u/dduportal/docker-compose/
http://stackoverflow.com/questions/29289785/how-to-install-docker-compose-on-windows

`brew install docker-compose`
'pip install docker-compose'




for dev environments (with Vagrant) do this:
===

```
vagrant up
# wait 30 minutes for everything to build
vagrant ssh
```

now you are logged into the vagrant ubuntu machine with SSH.  in there type this:

```
cd docker
docker-compose up
```

This will start the uber app in a container, and the code will be accessible from the OS running Vagrant (i.e. Windows) in app/uber/

Open your brower and go to "http://localhost:8282/magfest"

--------------

getting a fresh copy (dev)
===

run the following commands from your host OS (i.e. windows)
```
vagrant halt
vagrant destroy
```

Then (AFTER COMMITTING ANY CODE CHANGES, WHICH WOULD BE DESTROYED) remove the local folder 'app/uber' which was copied by Docker into your local files.

You are now ready to pull down a new copy with the dev instructions

for production do this:
===

```
./build.sh
```

then

```
docker-compose up
```
(run with whatever options you like)

Which runs the actual container (you will also need to start a DB/etc)

--------------

Next steps!

From inside vagrant, run the following to insert an admin user:

```
docker exec docker_web_1 /uber/env/bin/sep insert_admin
```

Now you can login to the web app with username "magfest@example.com" and password "magfest"

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
