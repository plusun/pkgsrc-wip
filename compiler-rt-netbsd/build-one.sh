#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

netbsd_root=/public/

export PATH=$netbsd_root/tooldir/bin/:$PATH
export PATH=$netbsd_root/extern_tooldir/bin/:$PATH
$netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $@ clean
$netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $@ dependall
$netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $@
$netbsd_root/tooldir/bin/nbmake-amd64 -j$nr_threads $@ install
