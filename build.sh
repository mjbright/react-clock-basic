#!/bin/bash

ORG=mjbright

die() {
    echo "$0: die $*" >&2
    exit 1
}

#docker build -t mjbright/clock . && docker push mjbright/clock
#docker build --network=host --no-cache -t mjbright/clock . && docker push mjbright/clock


for version in 1 2 3 4 5 6; do
    IMAGE=${ORG}/clock:$version
    case $version in
        1) COLOR=blue;;
        2) COLOR=green;;
        3) COLOR=red;;
        4) COLOR=cyan;;
        5) COLOR=yellow;;
        *) COLOR=magenta;;
    esac

    sed -e "s/__COLOR__/$COLOR/g" -e "s?__IMAGE__?$IMAGE?g" < Dockerfile.tmpl > Dockerfile
    [ ! -s Dockerfile ] && die "Created empty Dockerfile"
    grep __ Dockerfile  && die "Trailing template variable in Dockerfile"

    CMD="docker build --network=host -t $IMAGE ."
    echo; echo "-- [COLOR=$COLOR] $CMD"; $CMD
    [ $? -ne 0 ] && die "Build of $IMAGE failed ... stopping"
done

for version in 1 2 3 4 5 6; do
    IMAGE=${ORG}/clock:$version
    CMD="docker push $IMAGE"
    echo; echo "-- $CMD"; $CMD
done

# tagless version: as v1
CMD="docker tag ${ORG}/clock:1 ${ORG}/clock"
echo; echo "-- $CMD"; $CMD

CMD="docker push ${ORG}/clock"
echo; echo "-- $CMD"; $CMD

# Ubuntu based?:
# docker build -f Dockerfile.node -t mjbright/clock . && docker push mjbright/clock
