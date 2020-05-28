#!/bin/sh

HOST=$(hostname)

#INFO="Served from host ${HOST} image __IMAGE__"; sed -i.bak -e "s/__INFO__/$INFO/" /usr/src/app/src/components/App.js;
INFO="HELLO from $HOST ($COLOR) ($IMAGE)"

# Start nginx reverse-proxy:
nginx

# Start simple Node client (for curl/wget):
#cd frontend
node src/frontend/node_server.js $COLOR "$INFO" 2>&1 | tee /tmp/app.node.log &
#cd -

# Start React Clock App:
npm start 2>&1 | tee /tmp/app.react.log


