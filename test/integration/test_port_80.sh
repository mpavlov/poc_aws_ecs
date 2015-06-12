#!/bin/bash -e
HOST=${1:-localhost}
curl -isS "$HOST" | grep "200 OK"
