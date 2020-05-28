#!/bin/bash

#IPORT=8080
#IPORT=9090
#REDIRECTS="-p 8080:80 -p 19090:19090 -p 18080:18080"
IPORT=80
EPORT=8080

REDIRECTS="-p ${EPORT}:${IPORT}"

if [ "$1" = "-debug" ]; then
    shift
    docker run         $REDIRECTS mjbright/clock $*
else
    docker run -d --rm $REDIRECTS mjbright/clock $*
fi

