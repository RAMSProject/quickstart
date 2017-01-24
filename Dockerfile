FROM ramsproject/rams

#ENV SFTP_USER docker
#ENV SFTP_PASS changeme
#ENV PASS_ENCRYPTED false

##################################################
# Add SSH/SFTP support so PyCharm can connect    #
# Note, we only do this on the developer install #
##################################################
RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/*
# sshd needs this directory to run
RUN mkdir -p /var/run/sshd
ADD sshd_config /etc/ssh/sshd_config
ADD entrypoint /
EXPOSE 22
# entrypoint script starts sshd and then Sideboard
ENTRYPOINT ["/entrypoint"]

##########################################################
# Add our local plugins and install any new dependencies #
# that weren't already on the Docker Hub image           #
# This is done LAST so builds can be cached properly     #
##########################################################
ADD src plugins/
ADD sideboard-development.ini ./development.ini
RUN /app/env/bin/paver install_deps