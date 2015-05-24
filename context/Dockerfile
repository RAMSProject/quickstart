FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN apt-get -y update && apt-get -y install git python3 python3-tk gcc python3-dev libpq-dev && apt-get clean

# setup SSH keys for github access. 
# this assumes you copied your own SSH key into 
# the same dir that you are running this container from
# may want to re-think this later, and also make sure this container
# doesn't save this key after the build
# ADD id_rsa /root/.ssh/id_rsa
# RUN /bin/echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber

WORKDIR /uber
RUN git clone https://github.com/magfest/ubersystem plugins/uber

RUN python3 -m venv /uber/env --without-pip --copies

RUN /uber/env/bin/python3 /uber/plugins/uber/distribute_setup.py
RUN /uber/env/bin/python3 setup.py develop

RUN /uber/env/bin/paver install_deps

CMD /uber/env/bin/python3 /uber/sideboard/run_server.py

# HTTP port that cherrypy (uber) listens on
EXPOSE 4321
