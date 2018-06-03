#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 work_dir target_dir"
    exit 1
fi

set -e
set -x

netbsd_root=`readlink -f $1`
target_dir=`readlink -f $2`

count=0
target=
for i in $@; do
    count=$(($count + 1))
    if [ $count -ne 1 ] && [ $count -ne 2 ]; then
	target=$target" "$i
    fi
done

export PATH=$netbsd_root/tooldir/bin/:$PATH
export PATH=$netbsd_root/extern_tooldir/bin/:$PATH
(cd $target_dir; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $target clean; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $target dependall; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $target; \
 $netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $target install)
