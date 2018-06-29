#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 netbsd_destdir llvm_bin_dir no_link sanitizers"
    exit 1
fi

set -e
set -x

netbsd_destdir=`readlink -f $1`
no_link=$3
MAKE_FLAGS='DESTDIR='"$netbsd_destdir/"' USETOOLS=no MKLLVM=yes HAVE_LLVM=yes MKGCC=no'
SANITIZERS=$4

count=0
target=
for i in $@; do
    count=$(($count + 1))
    if [ $count -gt 4 ]; then
	target=$target" "$i
    fi
done

if [ "$SANITIZERS" = "none" ]; then
    SANFLAGS=""
else
    SANFLAGS='-fsanitize='"$SANITIZERS"''
fi
LLVM_BIN=`readlink -f $2`
COMPILE_FLAGS='"$SANFLAGS" -g -O0'
LINK_FLAGS='"$SANFLAGS" -g -O0'
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
