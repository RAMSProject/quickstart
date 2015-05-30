FROM magfest/uber-base
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber

WORKDIR /uber
RUN git clone https://github.com/magfest/ubersystem -b docker plugins/uber

RUN /env/bin/python3 /uber/plugins/uber/distribute_setup.py
RUN /env/bin/python3 setup.py develop

RUN /env/bin/paver install_deps

CMD /env/bin/python3 /uber/sideboard/run_server.py
EXPOSE 8282 # http
