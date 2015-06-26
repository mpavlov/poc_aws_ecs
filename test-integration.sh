#!/bin/bash

function remove_containers() {
  local output=$(docker ps -q | xargs docker rm --force)
  echo -e "$output"
}

function fail_with() {
  echo $1
  remove_containers
  exit 1
}

function compose() {
  docker-compose up -d
  [[ $? != 0 ]] && fail_with "Failed to compose"
}

function get_docker_host() {
  if [[ -z $DOCKER_HOST ]]; then
    echo localhost
  else
    echo $DOCKER_HOST | sed 's|.*://\(.*\):.*|\1|g'
  fi
}

function run_tests() {
  local host=$(get_docker_host)
  [[ -z $host ]] && fail_with "Error: could not determine docker host - is \$DOCKER_HOST set?"

  compose

  for test_file in test/integration/test_*; do
    echo "  ====== $test_file ======"
    $test_file $host
    [[ $? != 0 ]] && echo "Failed integration tests" && break
  done

  remove_containers
}

run_tests
