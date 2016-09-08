#!/bin/bash

# DOCKER

if [ -n "$(which docker-machine)" ]; then
  if [ "$(docker-machine status)" = "Running" ]; then
    eval $(docker-machine env)
  fi

  function docker() {
    if [ "$1" = "ps" ]; then
      "$( which docker )" "$@" | sed "s/0\.0\.0\.0/$( docker-machine ip )/g"
    else
      "$( which docker )" "$@"
    fi
  }

  function docker-machine() {
    "$( which docker-machine )" "$@"
    if [ "$1" = "start" ]; then
      eval $(docker-machine env)
    fi
  }
fi

# END DOCKER
