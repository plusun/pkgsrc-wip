#!/bin/sh

if [ "$#" -lt 5 ]; then
    echo "Usage: $0 tool netbsd_destdir llvm_bin_dir no_link sanitizers"
    exit 1
fi
tool=$1
destdir=$2
llvm_bin=$3
no_link=$4
sanitizers=$5
nr_threads=`getconf NPROCESSORS_CONF`

set -e
set -x

$tool $destdir $llvm_bin $no_link $sanitizers clean
$tool $destdir $llvm_bin $no_link $sanitizers -j$nr_threads
$tool $destdir $llvm_bin $no_link $sanitizers install
