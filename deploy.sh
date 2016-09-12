#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" != "false"] ; then
  echo "Skipping deploy on pull request"
  exit 0
fi


if [ $TRAVIS_BRANCH == 'master' ] ; then
  docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
  docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
  docker push $REPO
fi
