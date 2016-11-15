#!/bin/bash
set -x
set -e

# pre build
docker pull cargo.caicloud.io/caicloud/golang
# docker load -i script/golang.tar
git clone https://github.com/zoumo/go_test.git $PWD/go_test
docker run --rm -v $PWD/go_test:/go/src/github.com/zoumo/go_test -w /go/src/github.com/zoumo/go_test cargo.caicloud.io/caicloud/golang sh build.sh

# build
docker build -t integration $PWD/go_test

# integration
docker run --rm integration

# publish

echo done

