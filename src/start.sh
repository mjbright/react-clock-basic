#!/bin/sh

#exec >/tmp/exec.log 2>&1
exec 2>&1 | tee /tmp/exec.log

set -x

HOST=$(hostname)

#INFO="Served from host ${HOST} image __IMAGE__"; sed -i.bak -e "s/__INFO__/$INFO/" /usr/src/app/src/components/App.js;
#INFO="Served from $HOST <image $IMAGE>"
INFO="Server $HOST, image $IMAGE"
sed -i.bak -e "s?__INFO__?$INFO?" /usr/src/app/src/components/App.js

# Start nginx reverse-proxy:
nginx

# Start simple Node client (for curl/wget):
#cd frontend
node src/frontend/node_server.js $COLOR "$INFO" 2>&1 | tee /tmp/app.node.log &
#cd -

# Start React Clock App:
npm start 2>&1 | tee /tmp/app.react.log


