#!/bin/bash

db-docker-connect()
{
    # list running container
    docker ps

    docker ps --format '{{.Names}}'
}

