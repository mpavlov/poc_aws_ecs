#!/bin/bash -xe

ENV="$1"

function configure() {
  [[ "$ENV" == "" ]] && return
  doc_env=$([[ "$ENV" == "prod" ]] && echo "cqa" || echo "fqa")

  consul-template \
    -consul consul1.${doc_env}.doc.amplifyinsight.net:8500 \
    -template "/consul-template/index.html:/usr/share/nginx/html/index.html" \
    -once
}

function run() {
  nginx -g "daemon off;"
}

configure
run
