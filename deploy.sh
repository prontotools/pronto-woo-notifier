#!/bin/bash

docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO
