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

# issue: we can't use symlinks with SMB shares on windows+vagrant
# python -m venv --copies is supposed to not use symlinks but is broken.
# 
# This is fixed upstream but the fix is not in ubuntu 14.04 yet.
#
# This fix is not necessary for docker in production containers, 
# but, it is necessary for any interactions with docker+vagrant+windows
ADD venv-symlink-fix.patch /tmp/venv-symlink-fix.patch
RUN patch /usr/lib/python3.4/venv/__init__.py < /tmp/venv-symlink-fix.patch

# setup a virtual environment
RUN pip3 install virtualenv
RUN virtualenv /env
# RUN python3 -m venv /env --copies --without-pip

ADD guess_and_install_uber_requirements.sh /tmp/
RUN /tmp/guess_and_install_uber_requirements.sh
