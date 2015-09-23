FROM ramsproject/rams

ADD src plugins/

RUN pip3 install virtualenv
RUN virtualenv --always-copy /app/env
RUN paver install_deps
RUN /app/env/bin/python3 setup.py develop

CMD /app/env/bin/python3 /app/sideboard/run_server.py
