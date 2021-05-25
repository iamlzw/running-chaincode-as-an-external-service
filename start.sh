#!/bin/sh

export COMPOSE_PROJECT_NAME=net

docker-compose -f docker-compose-net.yaml up -d
