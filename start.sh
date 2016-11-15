#!/bin/bash
set -x
set -e

# pre build
docker pull cargo.caicloud.io/caicloud/golang
docker tag cargo.caicloud.io/caicloud/golang golang
# docker load -i script/golang.tar
git clone https://github.com/zoumo/go_test.git $PWD/go_test
docker run --rm -v $PWD/go_test:/go/src/github.com/zoumo/go_test -w /go/src/github.com/zoumo/go_test golang sh build.sh

# build
docker build -t integration $PWD/go_test

# integration
docker run --rm integration

# publish

echo done

