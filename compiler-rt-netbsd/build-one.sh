#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 work_dir target_dir"
    exit 1
fi

set -e
set -x

netbsd_root=`readlink -f $1`
target_dir=`readlink -f $2`

export PATH=$netbsd_root/tooldir/bin/:$PATH
export PATH=$netbsd_root/extern_tooldir/bin/:$PATH
(cd $target_dir; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads clean; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads dependall; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads ; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads install)
