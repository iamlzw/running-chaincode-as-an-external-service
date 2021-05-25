#!/bin/sh

docker-compose -f docker-compose-orderer.yaml down
#docker-compose -f docker-compose-orderer2.yaml down
#docker-compose -f docker-compose-orderer3.yaml down
docker volume prune
