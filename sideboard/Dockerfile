FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN apt-get -y update && \
  apt-get -y install \
    git \
    python3 \
    python3-gdbm \
    python3-tk \
    gcc \
    python3-dev \
    libpq-dev \
    wamerican \
    language-pack-id && \
  locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 && \
  dpkg-reconfigure locales

# download the main Sideboard repo and install its dependencies
RUN git clone https://github.com/magfest/sideboard -b docker /app && \
  python3 setup.py develop && \
  paver install_deps

CMD /app/env/bin/python3 /app/sideboard/run_server.py
EXPOSE 8282
