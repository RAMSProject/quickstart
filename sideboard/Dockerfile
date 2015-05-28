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
  apt-get clean && \
  locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 && \
  dpkg-reconfigure locales

# download the main uber deploy repo
# TODO: also here install any plugins you want
RUN git clone https://github.com/magfest/sideboard -b docker /uber
