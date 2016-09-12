#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" != "false" -o  "$TRAVIS_BRANCH" != "master" ]; then
    echo "Skiping Deploy, Just run test"
    exit 0
fi

docker build -t $REPO:$COMMIT -f ./compose/rails/Dockerfile .
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
docker push $REPO

openssl aes-256-cbc -k $DEPLOY_KEY -in config/deploy_id_rsa_enc_travis -d -a -out config/deploy_id_rsa

sed -i 's/image: {}/image: $REPO:$COMMIT/g' docker-compose.production.yml
scp docker-compose.production.yml ubuntu@$PRODUCTION_IP:/home/ubuntu
fab production deploy
