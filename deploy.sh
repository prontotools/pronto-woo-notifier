#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" != "false" -o  "$TRAVIS_BRANCH" != "master" ]; then
    echo "Skiping Deploy, Just run test"
    exit 0
fi

docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO
