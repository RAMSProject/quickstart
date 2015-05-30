# create a base ubuntu image with a lot of python stuff installed already
# then, try and guess dependencies that sideboard+ubersystem might need,
# install them in the virtualenv, so that images based off this container
# will be able to skip a lot of the install

FROM ubuntu:14.04
MAINTAINER Dominic Cerquetti "dom@magfest.org"

# base system stuff
RUN 	apt-get -y update && \
	apt-get -y install \
		git \
		gcc \
		python3 \
		python3-gdbm \
		python3-tk \
		python3-dev \
		python3-pip \
		vim-scripts \
		libpq-dev \
		wamerican \
		language-pack-id \
		wget && \
	apt-get clean && \
	locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 && \
	dpkg-reconfigure locales

# setup a virtual environment
RUN pip3 install virtualenv
RUN virtualenv /env
# RUN python3 -m venv /env --copies --without-pip

ADD guess_and_install_uber_requirements.sh /tmp/
RUN /tmp/guess_and_install_uber_requirements.sh
