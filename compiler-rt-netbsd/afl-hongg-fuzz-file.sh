#!/bin/sh

. ./afl-honggfuzz-header.sh

update_branch gsoc2018
build $src/lib/libz
build $src/external/bsd/file

install_fuzzer

input=file-$fuzzer-input
output=file-$fuzzer-output
mkdir -p $destdir/$input
mkdir -p $destdir/$output

echo "hello, world!" > $destdir/$input/initial

case $fuzzer in
    afl-fuzz)
	chroot $destdir afl-fuzz -i /$input -o /$output -m none -t 300+ /usr/bin/file @@
	;;
    honggfuzz)
	chroot $destdir honggfuzz -f /$input -x -s -- /usr/bin/file __FILE__
	;;
    *)
	;;
esac

