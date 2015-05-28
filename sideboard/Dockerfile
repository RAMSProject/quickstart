FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN apt-get -y update && \
  apt-get -y install \
    git \
    python3 \
    python3-gdbm \
    python3-tk \
    python3-pip \
    gcc \
    python3-dev \
    libpq-dev \
    wamerican \
    language-pack-id && \
  locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 && \
  dpkg-reconfigure locales

WORKDIR /app

# download the main Sideboard repo and install its dependencies
RUN git clone https://github.com/magfest/sideboard -b docker /app && \
  pip3 install virtualenv && \
  virtualenv /app/env && \
  /app/env/bin/python3 setup.py develop

CMD /app/env/bin/python3 /app/sideboard/run_server.py
EXPOSE 8282
