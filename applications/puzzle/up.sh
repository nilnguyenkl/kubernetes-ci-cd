#!/usr/bin/env bash
HOSTNAME=`hostname`
curl "http://host.docker.internal:3001/up/$HOSTNAME"
# curl "http://monitor-scale:3001/up/$HOSTNAME"
