#!/bin/bash

APPNAME=<%= appName %>
APP_PATH=/opt/$APPNAME
BUNDLE_PATH=$APP_PATH/current
ENV_FILE=$APP_PATH/config/env.list
PORT=<%= port %>

# remove previous version of the app, if exists
docker rm -f $APPNAME

# remove frontend container if exists
docker rm -f $APPNAME-frontend

set -e
docker pull meteorhacks/meteord:base

  docker run \
    -d \
    --restart=always \
    --publish=$PORT:80 \
    --volume=$BUNDLE_PATH:/bundle \
    --env-file=$ENV_FILE \
    --link=mongodb:mongodb \
    --hostname="$HOSTNAME-$APPNAME" \
    --env=MONGO_URL=mongodb://mongodb:27017/hubdb \
    --name=$APPNAME \
    meteorhacks/meteord:base
