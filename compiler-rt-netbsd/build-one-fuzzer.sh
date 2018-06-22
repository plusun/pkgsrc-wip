#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 work_dir no_link sanitizers"
    exit 1
fi

set -e
set -x

netbsd_root=`readlink -f $1`
no_link=$2
MAKE_FLAGS='DESTDIR='"$netbsd_root/destdir/"' USETOOLS=no MKLLVM=yes HAVE_LLVM=yes MKGCC=no'
SANITIZERS=$3

count=0
target=
for i in $@; do
    count=$(($count + 1))
    if [ $count -gt 3 ]; then
	target=$target" "$i
    fi
done

if [ "$SANITIZERS" = "none" ]; then
    SANITIZERS=''
else
    SANITIZERS=','"$SANITIZERS"''
fi
LLVM_BIN=$netbsd_root/destdir/usr/bin/
COMPILE_FLAGS='-DENABLE_FUZZER -fsanitize=fuzzer-no-link'"$SANITIZERS"' -g -O0'
LINK_FLAGS='-DENABLE_FUZZER -fsanitize=fuzzer'"$SANITIZERS"' -g -O0'
CCFLAGS='CC='"$LLVM_BIN"'/clang CFLAGS="'"$COMPILE_FLAGS"'" CXX='"$LLVM_BIN"'/clang++ CXXFLAGS="'"$COMPILE_FLAGS"'"'
LDFLAGS='LDFLAGS="'"$LINK_FLAGS"'"'
LIB_LDFLAGS='LDFLAGS="'"$COMPILE_FLAGS"'"'

if [ "$no_link" = "true" ]; then
    ALL_FLAGS="$MAKE_FLAGS $CCFLAGS $LIB_LDFLAGS"
else
    ALL_FLAGS="$MAKE_FLAGS $CCFLAGS $LDFLAGS"
fi

build="make $ALL_FLAGS $target"
eval $build
