#!/bin/bash -e
HOST=${1:-localhost}
curl -isS "${HOST}:21080" | grep "200 OK"
