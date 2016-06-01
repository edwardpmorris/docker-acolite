# Debian, RBINS-ACOLITE Dockerfile
# https://github.com/edwardpmorris/docker-acolite
# acolite from https://odnature.naturalsciences.be/remsem/software-and-data/acolite

# pull base image (use a specific version tag ':tag')
FROM  debian:8

# maintainer details
MAINTAINER epmorris "edward.morris@uca.es"

# update version label
LABEL acolite_version='20160520.1'

# update and add packages
RUN apt-get update -y && apt-get install -y \
      nano \
      wget \
      curl \
    && rm -fr /var/lib/apt/lists/*

# create user group, set UID to volume
RUN mkdir /home/worker \
    && groupadd -r worker -g 1000 \
    && useradd -u 431 -r -g worker -d /home/worker -s /sbin/nologin -c "Docker image user" worker \
    && chown -R worker:worker /home/worker

# set some env variables
ENV ACOLITE_VERSION='20160520.1' \
    ACOLITE_URL="https://odnature.naturalsciences.be/downloads/remsem/acolite" \
    HOME=/home/worker

# set work directory to home
WORKDIR $HOME

# download, check, extract and clean up sen2cor install from step.esa.int
# FIXME: improve verification, https://github.com/docker-library/official-images
ENV ACOLITE_DOWNLOAD_SHA256 20e5d5e840ec8bfd7989e57e0ee5fb2c37e01b6da63098f2b3a6c7d30ff3b10d
RUN curl -fSL -o acolite_linux_${ACOLITE_VERSION}.tar.gz "${ACOLITE_URL}/acolite_linux_${ACOLITE_VERSION}.tar.gz" \
    && echo "$ACOLITE_DOWNLOAD_SHA256 *acolite_linux_${ACOLITE_VERSION}.tar.gz" | sha256sum -c - \
    && tar -xvzf acolite_linux_${ACOLITE_VERSION}.tar.gz \
    && rm acolite_linux_${ACOLITE_VERSION}.tar.gz

# acolite runs from its directory, fix permission issues
# FIXME: is this the 'best' way to do permissions?
RUN chown -R worker:worker $HOME/acolite_linux \
    && chmod -R g+w $HOME/acolite_linux \
    && chgrp -R worker $HOME/acolite_linux

# update and add packages
# hang on are these for the graphical interface?
RUN apt-get update -y && apt-get install -y \
    libfreetype6 \
    libxp6 \
    libxpm4 \
    libxmu6 \
    && rm -fr /var/lib/apt/lists/*

USER worker

WORKDIR $HOME/acolite_linux
