FROM magfest/uber-base
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber

WORKDIR /uber
RUN git clone https://github.com/magfest/ubersystem plugins/uber

RUN /uber/env/bin/pip3 install -e /uber
RUN /uber/env/bin/pip3 install -e /uber/plugins/uber

CMD /uber/env/bin/python3 /uber/sideboard/run_server.py
EXPOSE 8282 
