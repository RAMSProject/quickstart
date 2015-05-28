FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN apt-get -y update && apt-get -y install git python3 python3-gdbm python3-tk gcc python3-dev libpq-dev wamerican language-pack-id && apt-get clean

RUN locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8
dpkg-reconfigure locales

# there is a bug in python -m venv which doesnt obey --copies
# (i.e. don't do any symlinks). We have submitted this to CPython
# for inclusion but for now, patch the installed python file.
# (we can't use symlinks with SMB shares).  May not be strictly necessary
# for docker in production, but, doesn't hurt to have this fix.
ADD venv-symlink-fix.patch /tmp/venv-symlink-fix.patch
RUN patch /usr/lib/python3.4/venv/__init__.py < /tmp/venv-symlink-fix.patch

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber

WORKDIR /uber
RUN git clone https://github.com/magfest/ubersystem -b docker plugins/uber

RUN python3 -m venv /uber/env --without-pip --copies

RUN /uber/env/bin/python3 /uber/plugins/uber/distribute_setup.py
RUN /uber/env/bin/python3 setup.py develop

RUN /uber/env/bin/paver install_deps

CMD /uber/env/bin/python3 /uber/sideboard/run_server.py

# HTTP port that cherrypy (uber) listens on
EXPOSE 8282
