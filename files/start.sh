#!/bin/bash

# Preferences
[ -f /etc/default/plexmediaserver ] && . /etc/default/plexmediaserver
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR:-${HOME}/Library/Application Support}"
PLEX_PREFERENCES="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server/Preferences.xml"
PLEX_PID="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server/plexmediaserver.pid"

# Remove previous pid if it exists
rm -f "${PLEX_PID}"

# Current defaults to run as root while testing.
if [ "${RUN_AS_ROOT,,}" = "true" ]; then
    /usr/sbin/start_pms
else
    su -c "/usr/sbin/start_pms" plex
fi
