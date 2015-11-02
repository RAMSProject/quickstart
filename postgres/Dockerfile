FROM postgres:9.4

RUN apt-get update \
	&& apt-get install -y python-pip python-dev lzop pv daemontools \
	&& apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && pip install virtualenv

RUN virtualenv --always-copy /venv \
  && /venv/bin/pip install wal-e

ADD setup-wale.sh /docker-entrypoint-initdb.d/
