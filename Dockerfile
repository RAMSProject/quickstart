FROM ramsproject/rams

ADD src plugins/
RUN /app/env/bin/paver install_deps

# derp, fix this to be done in sideboard instead
CMD /app/env/bin/python3 /app/sideboard/run_server.py
