#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "master" ] ; then

    docker pull apolyansky/docker-uptime:latest
    docker stop docker-uptime-container
    docker run -d -p 27017:27017 --restart=always -v /data/mongo:/data/db/ --name mongodb mongo
    docker run -d \
    --restart=always \
    --name docker-uptime-container \
    --link mongodb:mongodb \
    -p 8083:8082 \

    apolyansky/docker-uptime:latest

    # setup ssh agent, git config and remote
    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/travis_rsa
    # git remote add deploy "travis@webhost.planecq.xyz:/var/www/docker-uptime"
    # git config user.name "Travis CI"
    # git config user.email "travis@docker-uptime"
    #
    # # commit compressed files and push it to remote
    # rm -f .gitignore
    # cp .travis/deployignore .gitignore
    # git add .
    # git status # debug
    # git commit -m "Deploy compressed files"
    # git push -f deploy HEAD:master

elif [ $TRAVIS_BRANCH == "staging" ] ; then

    docker-compose up --build
    # # setup ssh agent, git config and remote
    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/travis_rsa
    # git remote add deploy "travis@webhost.planecq.xyz:/var/www/docker-uptime"
    # git config user.name "Travis CI"
    # git config user.email "travis@docker-uptime"
    #
    # # commit compressed files and push it to remote
    # rm -f .gitignore
    # cp .travis/deployignore .gitignore
    # git add .
    # git status # debug
    # git commit -m "Deploy compressed files"
    # git push -f deploy HEAD:master

else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi
