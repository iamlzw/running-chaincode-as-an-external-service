#!/bin/sh

export COMPOSE_PROJECT_NAME=net

docker-compose -f docker-compose-net.yaml down
#docker-compose -f docker-compose-orderer2.yaml down
#docker-compose -f docker-compose-orderer3.yaml down
docker volume prune
