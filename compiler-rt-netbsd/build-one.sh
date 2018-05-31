#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

export PATH=/usr/tooldir/bin/:$PATH
export PATH=/usr/extern_tooldir/bin/:$PATH
/usr/tooldir/bin/nbmake-amd64 -j$nr_threads $@ clean
/usr/tooldir/bin/nbmake-amd64 -j$nr_threads $@ dependall
/usr/tooldir/bin/nbmake-amd64 -j$nr_threads $@
/usr/tooldir/bin/nbmake-amd64 -j$nr_threads $@ install
