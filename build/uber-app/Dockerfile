FROM magfest/uber-base
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber/sideboard

WORKDIR /uber/sideboard
RUN git clone https://github.com/magfest/ubersystem -b master plugins/uber

RUN /uber/env/bin/pip3 install -e /uber/sideboard
RUN /uber/env/bin/pip3 install -e /uber/sideboard/plugins/uber

CMD /uber/env/bin/python3 /uber/sideboard/sideboard/run_server.py
EXPOSE 8282 
