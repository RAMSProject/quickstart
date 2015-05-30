#!/bin/bash

# run inside docker container as part of build
# this script is an opimization only and is completely unnecessary for
# normal builds.

# this script will compile a reasonable guess at what dependencies
# ubersystem and sideboard will want to install, and install them
# in /env.  When later images run 'setup.py install develop', most
# of the requirements packages will already have been installed,
# this skipping a lot of the build time.

# this is primarily used for development where doing builds 
# takes a while, and we want the ability to create builds as fast
# as possible.

SIDEBOARD_REPO='magfest/sideboard'
SIDEBOARD_BRANCH='master'

UBERCORE_REPO='magfest/ubersystem'
UBERCORE_BRANCH='master'

set -e

download_github_file()
{
	wget "https://raw.githubusercontent.com/$1/$2/$3"
}

install_python_reqs()
{
	REPO=$1
	BRANCH=$2

	download_github_file $REPO $BRANCH "requirements.txt"

	/env/bin/pip3 install -r "requirements.txt"

	rm -f "requirements.txt"
}

cd /tmp
install_python_reqs $SIDEBOARD_REPO $SIDEBOARD_BRANCH
install_python_reqs $UBERCORE_REPO $UBERCORE_BRANCH
