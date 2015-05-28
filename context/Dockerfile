FROM magfest/sideboard
MAINTAINER Dominic Cerquetti "dom@magfest.org"

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
