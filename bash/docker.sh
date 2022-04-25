#!/bin/bash

db-docker-connect()
{
    # list running container
    docker ps

    CONTAINER_NAME=$(docker ps --format '{{.Names}}' | fzf --height=10)

    docker exec -it "$@" $CONTAINER_NAME /bin/bash
}

