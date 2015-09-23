FROM ramsproject/rams

ADD src plugins/

WORKDIR /app/
RUN paver install_deps

CMD /app/env/bin/python3 /app/sideboard/run_server.py
