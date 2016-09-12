#!/bin/bash

set -e

if [ "$TRAVIS_PULL_REQUEST" != "false" -o  "$TRAVIS_BRANCH" != "master" ]; then
    echo "Skiping Deploy, Just run test"
    exit 0
fi

echo "Latest version: $COMMIT "
docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO

echo -e "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
openssl aes-256-cbc -K $encrypted_8946ec3bee6a_key -iv $encrypted_8946ec3bee6a_iv -in id_rsa.enc -out id_rsa -d
chmod 600 id_rsa
mv id_rsa ~/.ssh/id_rsa

echo "Starting deploy...."
pip install fabric
sed -i "s#image: {}#image: $REPO:$COMMIT#g" docker-compose.production.yml
scp docker-compose.production.yml ubuntu@$PRODUCTION_IP:/home/ubuntu
fab production deploy
