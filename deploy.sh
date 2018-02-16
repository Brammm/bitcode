#!/usr/bin/env bash

DOCKER_TUNNEL_CONTAINER=docker_swarm_ssh_tunnel
DOCKER_TUNNEL_PORT=12374
DOCKER_SWARM_HOST=174.138.10.79
DEPLOY_USER=root
DOCKER_STACK_FILE=env/prod/docker-compose.yml
DOCKER_STACK_NAME=brammm

sudo docker run \
    -d \
    --name ${DOCKER_TUNNEL_CONTAINER} \
    -v ${SSH_AUTH_SOCK}:/ssh-agent \
    -p ${DOCKER_TUNNEL_PORT}:${DOCKER_TUNNEL_PORT} \
    kingsquare/tunnel \
    *:${DOCKER_TUNNEL_PORT}:/var/run/docker.sock \
    ${DEPLOY_USER}@${DOCKER_SWARM_HOST}


until sudo docker -H localhost:${DOCKER_TUNNEL_PORT} version 2>/dev/null 1>/dev/null > /dev/null; do
    echo "Waiting for docker tunnel";
    sleep 1;
done

sudo docker \
    -H localhost:${DOCKER_TUNNEL_PORT} \
    stack deploy \
    --with-registry-auth \
    -c ${DOCKER_STACK_FILE} \
    --prune \
    ${DOCKER_STACK_NAME}

sudo docker stop ${DOCKER_TUNNEL_CONTAINER}
sudo docker rm ${DOCKER_TUNNEL_CONTAINER}
