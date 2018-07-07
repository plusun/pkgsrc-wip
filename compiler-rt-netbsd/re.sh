#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 tool [other options]"
    exit 1
fi
tool=$1
nr_threads=`getconf NPROCESSORS_CONF`
count=0
options=
for i in $@; do
    count=$(($count + 1))
    if [ $count -gt 1 ]; then
	options=$options" "$i
    fi
done

set -e
set -x

$tool $options clean
$tool $options
$tool $options clean
$tool $options -j$nr_threads
$tool $options install
