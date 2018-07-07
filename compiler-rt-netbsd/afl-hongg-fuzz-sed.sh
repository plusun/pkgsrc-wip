#!/bin/sh

. ./afl-honggfuzz-header.sh

update_branch gsoc2018
build $src/usr.bin/sed

install_fuzzer

input=sed-$fuzzer-input
output=sed-$fuzzer-output
mkdir -p $destdir/$input
mkdir -p $destdir/$output

echo "hello, world!" > $destdir/$input/initial

case $fuzzer in
    afl-fuzz)
	chroot $destdir afl-fuzz -i /$input -o /$output -m none -t 300+ /usr/bin/sed s/hello/hi/g @@
	;;
    honggfuzz)
	chroot $destdir honggfuzz -f /$input -x -s -- /usr/bin/sed s/hello/hi/g __FILE__
	;;
    *)
	;;
esac

