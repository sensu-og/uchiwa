#!/bin/sh

set -e

pushd ../uchiwa-web
npm install --production
popd

mkdir -p public/bower_components/uchiwa-web
npm install --production
cp -a ../uchiwa-web/* public/bower_components/uchiwa-web/

docker build ./build/ -t sensu-builder

rm *.deb *.rpm

docker run --rm -v "$(pwd):/go/src/github.com/sensu/uchiwa" sensu-builder ./build/travis.sh

ls -l *.deb *.rpm

