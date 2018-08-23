#!/usr/bin/env bash

rm -rf $GOPATH/src/github.com/golang/mock && go get -u github.com/wangshao1/mock/mockgen && curl https://raw.githubusercontent.com/wangshao1/mock/master/mockgen/go-mockgen.sh > /usr/local/bin/go-mockgen && chmod +x /usr/local/bin/go-mockgen || exit 1

echo "Install successfully"
