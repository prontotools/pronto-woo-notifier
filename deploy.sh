#!/bin/bash

set -x

if [ "$TRAVIS_PULL_REQUEST" != "false" -o  "$TRAVIS_BRANCH" != "master" ]; then
    echo "Skiping Deploy, Just run test"
    exit 0
fi

echo "Latest version: $COMMIT "
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO

echo -e "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
openssl aes-256-cbc -K $encrypted_5912ca40cb57_key -iv $encrypted_5912ca40cb57_key -in deploy_key.enc -out deploy_key -d
chmod 400 deploy_key
mv deploy_key ~/.ssh/id_rsa

echo "Starting deploy...."
pip install fabric
sed -i "s#image: {}#image: $REPO:$COMMIT#g" docker-compose.production.yml
scp docker-compose.production.yml ubuntu@$PRODUCTION_IP:/home/ubuntu
fab production deploy
