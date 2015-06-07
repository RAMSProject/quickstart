#!/bin/bash

# set git to ignore file permissions on windows
# this is needed because accessing git repos FROM windows that were 
# created in the VM by linux causes git to try and set every file to
# 777 since window's file permissions are incompatible with linux.
#
# HACKY AS HELL, but it works.
#
# TODO: I really wish this was a global config option so we didn't have
# to iterate through all the repos.  what a drag.

if [ -e /etc/is_running_vagrant_on_windows ]
then 
	echo "Fixing broken file permissions in git since we're on Windows..."
	find /home/vagrant/docker -type d -name '.git' | while read -r FILE
	do
		git config --file "$FILE/config" core.filemode false
	done
fi
