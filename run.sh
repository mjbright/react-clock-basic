#!/bin/bash

ORG=mjbright

#IPORT=8080
#IPORT=9090
#PORT_REDIR="-p 8080:80 -p 19090:19090 -p 18080:18080"
IPORT=80
EPORT=8080

PORT_REDIR="-p ${EPORT}:${IPORT}"

die() {
    echo "$0: die $*" >&2
    exit 1
}

DEBUG=0
IMAGE=$ORG/clock

while [ ! -z "$1" ]; do
    case $1 in
        [1-6]) VERSION=$1; IMAGE=$ORG/clock:$VERSION;;
        -d|-debug|--debug) DEBUG=1;;
        *) die "Unknown option <$1>";;
    esac
    shift
done

if [ $DEBUG -eq 0 ]; then
    docker run         $PORT_REDIR $IMAGE $*
else
    docker run -d --rm $PORT_REDIR $IMAGE $*
fi

