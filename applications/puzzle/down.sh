#!/usr/bin/env bash
HOSTNAME=`hostname`
curl "http://host.docker.internal:3001/down/$HOSTNAME"
# curl "http://monitor-scale:3001/down/$HOSTNAME"
# Change type file