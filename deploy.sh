#!/bin/bash
set -x
set -e

if [ "$TRAVIS_PULL_REQUEST" != "false" -o  "$TRAVIS_BRANCH" != "master" ]; then
    echo "Skiping Deploy, Just run test"
    exit 0
fi

echo "Latest version: $COMMIT "
docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO

echo "Starting deploy...."
pip install fabric
sed -i 's/image: {}/image: $REPO:$COMMIT/g' docker-compose.production.yml
scp docker-compose.production.yml ubuntu@$PRODUCTION_IP:/home/ubuntu
fab production deploy
