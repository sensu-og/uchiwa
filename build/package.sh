#!/bin/sh

set -e

npm install --production

docker build ./build/ -t sensu-builder

rm *.deb *.rpm || true

docker run --rm -v "$(pwd):/go/src/github.com/sensu/uchiwa" sensu-builder ./build/travis.sh

ls -l *.deb *.rpm

