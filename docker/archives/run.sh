#!/bin/sh

#export DOCKER_SUBNET=10.255.255.0/24
#echo ${DOCKER_SUBNET}

if [ -z "$DOCKER_SUBNET" ]; then
  docker-compose -f docker-compose.yml -f docker-compose-net-auto.yml up
else
  docker-compose -f docker-compose.yml -f docker-compose-net-subnet.yml up
fi

