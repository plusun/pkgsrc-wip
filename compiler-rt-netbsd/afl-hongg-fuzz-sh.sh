#!/bin/sh

. ./afl-honggfuzz-header.sh

update_branch gsoc2018
build $src/bin/sh

install_fuzzer

input=sh-$fuzzer-input
output=sh-$fuzzer-output
mkdir -p $destdir/$input
mkdir -p $destdir/$output

echo "echo hello, world!" > $destdir/$input/initial

case $fuzzer in
    afl-fuzz)
	chroot $destdir afl-fuzz -i /$input -o /$output -m none -t 300+ /bin/sh @@
	;;
    honggfuzz)
	chroot $destdir honggfuzz -f /$input -x -s -- /bin/sh __FILE__
	;;
    *)
	;;
esac

