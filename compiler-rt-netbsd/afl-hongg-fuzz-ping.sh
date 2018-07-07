#!/bin/sh

. ./afl-honggfuzz-header.sh

update_branch afl-hongg-expr
build $src/sbin/ping
build $src/lib/libipsec

install_fuzzer

input=ping-$fuzzer-input
output=ping-$fuzzer-output
mkdir -p $destdir/$input
mkdir -p $destdir/$output

echo "hello, world!" > $destdir/$input/initial

case $fuzzer in
    afl-fuzz)
	afl-fuzz -i $destdir/$input -o $destdir/$output -m none -t 1000+ $destdir/sbin/ping
	;;
    honggfuzz)
	honggfuzz -f $destdir/$input -x -s -- $destdir/sbin/ping
	;;
    *)
	;;
esac

