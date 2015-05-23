FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN apt-get -y update
RUN apt-get -y install git ssh python3

# setup SSH keys for github access. 
# this assumes you copied your own SSH key into 
# the same dir that you are running this container from
# may want to re-think this later, and also make sure this container
# doesn't save this key after the build
# ADD id_rsa /root/.ssh/id_rsa
# RUN /bin/echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard /uber
RUN git clone https://github.com/magfest/ubersystem /uber/sideboard/plugins

RUN python3 -m venv /uber/env --without-pip --copies

WORKDIR /uber
RUN env/bin/python3 sideboard/plugins/distribute_setup.py
RUN env/bin/python3 setup.py develop
RUN env/bin/paver install_deps

# EXPOSE 4321 # HTTP port that cherrypy (uber) listens on
