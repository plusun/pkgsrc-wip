#!/bin/sh

. ./afl-honggfuzz-header.sh

update_branch afl-hongg-expr
build $src/bin/expr

install_fuzzer

input=expr-$fuzzer-input
output=expr-$fuzzer-output
mkdir -p $destdir/$input
mkdir -p $destdir/$output

echo "1 + 1" > $destdir/$input/initial

case $fuzzer in
    afl-fuzz)
	chroot $destdir afl-fuzz -i /$input -o /$output -m none -t 300+ /bin/expr
	;;
    honggfuzz)
	chroot $destdir honggfuzz -f /$input -x -s -- /bin/expr
	;;
    *)
	;;
esac

