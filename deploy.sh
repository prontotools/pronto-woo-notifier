#!/bin/bash
TARGET_BRANCH="master"

if [ "$TRAVIS_PULL_REQUEST" != "false" -o $TRAVIS_BRANCH != $TARGET_BRANCH] ; then
  echo "Skipping deploy, Just doing a build"
  exit 0
fi

docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO
