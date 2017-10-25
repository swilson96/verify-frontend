#!/bin/bash -eu

bundle
export HEADLESS=true
export DISPLAY=:0
export BUILD_NUMBER=1
# ./pre-commit.sh
echo ${BUILD_NUMBER} > .build-number

bundle exec dotenv echo ${RP_DISPLAY_LOCALES}

SECRET_KEY_BASE=no-secret RAILS_ENV=production bundle exec dotenv rake assets:precompile
SECRET_KEY_BASE=no-secret RAILS_ENV=production bundle exec dotenv rake tmp:clear

# We need to copy the manifest file to the root of the public/assets dir due
# to heroku-buildback hardcoding where the manifest file should be
cp public/assets/${BUILD_NUMBER}/.*.json public/assets/

bundle exec pkgr package . --buildpack=https://github.com/heroku/heroku-buildpack-ruby --version="${BUILD_NUMBER}" --iteration=1 --name=front --dependencies=front-assets-${BUILD_NUMBER} --env STACK=cedar-14
fpm --name front-assets-${BUILD_NUMBER}\
    --version 1\
    -C public/assets\
    --prefix /opt/front-assets\
    -s dir\
    -t deb\
    ${BUILD_NUMBER}/
