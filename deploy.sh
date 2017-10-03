#!/usr/bin/env bash

eval $(docker-machine env bitcode) && \
docker-compose pull && \
docker-compose -f env/prod/docker-compose.yml up -d && \
eval $(docker-machine env -u)
