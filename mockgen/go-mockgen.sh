#!/usr/bin/env bash

#!/bin/bash

paths='.'

while getopts hp: opt
do
    case "$opt" in
        h)
        echo "Usage: go-mockgen [-p path1,path2,path3]"
        exit 0;;
        p)
        paths=$OPTARG
        ;;
        ?)
        echo "Usage: go-mockgen [-p path1,path2,path3]"
        exit 1;;
    esac
done


arr=(${paths//,/ })
for path in ${arr[*]}
do
    echo "Generating Mock For: $path"
    rm -rf $path/mocks && mkdir $path/mocks || exit 1
    for gofile in `find $path -path $path/mocks/* -prune -o -path $path/vender/* -prune -o -type f -name "*.go" | grep -v "_test.go"`
    do
#      echo "$path/mocks/${gofile#*$path}"
      dir=`dirname $path/mocks/${gofile#*$path}`
      if [ ! -d $dir ]; then mkdir -p $dir; fi && touch $path/mocks/${gofile#*$path} && mockgen -source=$gofile -destination $path/mocks/${gofile#*$path} -package `basename $dir` || exit 1
    done
done

exit 0