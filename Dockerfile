#FROM node:8
FROM node:8-alpine

# Now divided into 2 parts
# - frontend: in frontend subdir
# - react:    in .

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If using alpine image: needed for module gyp2
RUN apk add python2 make g++ && \
    rm -rf /var/cache/apk/* && \
    npm install && \
    npm cache clean --force && \
    apk del python2 make g++

# Adding nginx as reverse-proxy to redirect to
# - 127.0.0.1:8080 - React Clock app
# - 127.0.0.1:9090 - Simple Node client for curl/wget requests
RUN apk add nginx

# Add nginx config: overwrite default.conf
COPY nginx.redirect.conf /etc/nginx/conf.d/default.conf
RUN mkdir /run/nginx # Necessary?

# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

ENV COLOR blue
ENV IMAGE mjbright/clock

EXPOSE 80

#CMD [ "npm", "start" ]
CMD [ "/bin/sh", "-c", "src/start.sh" ]

