# Based off vimagick/plex uses my own base image instead of debian:jessie
FROM limed/ubuntu-base
MAINTAINER limed@sudoers.org

# Handy information regarding package
ENV PLEX_VERSION 1.9.2.4285-9f65b88ae
ENV PLEX_FILE plexmediaserver_${PLEX_VERSION}_amd64.deb
ENV PLEX_URL https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/${PLEX_FILE}

# Location of directories and misc
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR "/var/lib/plexmediaserver/Library/Application Support"
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6

# Where are you storing your data
ENV MEDIA_DIR /data

RUN set -xe \
    && apt-get update \
    && curl -sSL ${PLEX_URL} -o ${PLEX_FILE} \
    && dpkg -i ${PLEX_FILE} \
    && apt-get install -f \
    && rm -rf ${PLEX_FILE} /var/lib/apt/lists/*

RUN set -xe \
    && mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}" \
    && mkdir -p "${MEDIA_DIR}" \
    && chmod -R a+rwX "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}"

VOLUME [ "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}", "${MEDIA_DIR}" ]

EXPOSE 1900/udp \
       3005/tcp \
       5353/udp \
       8324/tcp \
       32400/tcp \
       32410/udp \
       32412/udp \
       32413/udp \
       32414/udp \
       32469/tcp

ADD files/start.sh /start.sh
