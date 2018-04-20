#!/usr/bin/env bash

go get -u github.com/Guazi-inc/mock/mockgen
curl https://raw.githubusercontent.com/Guazi-inc/mock/master/mockgen/go-mockgen.sh > /usr/local/bin/go-mockgen
chmod +x /usr/local/bin/go-mockgen
echo "Install successfully"
