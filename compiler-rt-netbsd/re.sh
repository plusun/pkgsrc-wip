#!/bin/sh

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 tool work_dir no_link sanitizers"
    exit 1
fi
tool=$1
workdir=$2
no_link=$3
sanitizers=$4
nr_threads=`getconf NPROCESSORS_CONF`

set -e
set -x

$tool $workdir $no_link $sanitizers clean
$tool $workdir $no_link $sanitizers -j$nr_threads
$tool $workdir $no_link $sanitizers install
