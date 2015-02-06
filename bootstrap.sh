#!/bin/bash -xe

ENV="$1"

function configure() {
  [[ "$ENV" == "" ]] && return
  echo "The env is: $ENV" >> /usr/share/nginx/html/index.html
}

function run() {
  nginx -g "daemon off;"
}

configure
run
