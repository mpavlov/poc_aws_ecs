#!/bin/bash -e
HOST=${1:-localhost}
curl -isS "${HOST}:8080" | grep "200 OK"
