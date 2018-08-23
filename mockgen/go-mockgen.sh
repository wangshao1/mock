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
    for gofile in `find $path -type f -name "*.go" | grep ".go" | grep -v "_test.go"`
    #for gofile in `find $path -path $path/mocks -prune -o -type f -name "*.go" | grep ".go" | grep -v "_test.go"`#-path $path/vendor -prune -o 
    do
        if [ -f $gofile ]; then 
            dir=`dirname $path/mocks${gofile#*$path}`
            if [ ! -d $dir ]; then mkdir -p $dir; fi && \
            touch $path/mocks/${gofile#*$path} && \
            mockgen -source=$gofile -destination $path/mocks/${gofile#*$path} -package `basename $dir` fi || exit 1;
        fi
    done
done

exit 0