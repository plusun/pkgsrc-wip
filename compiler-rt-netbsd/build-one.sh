#!/bin/sh

nr_threads=`getconf NPROCESSORS_CONF`

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 cc cxx netbsd_destdir sanitizers|none"
    exit 1
fi

set -e
set -x

cc=$1
cxx=$2
netbsd_destdir=`readlink -f $3`
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
COMPILE_FLAGS='"$SANFLAGS" -g -O0'
LINK_FLAGS='"$SANFLAGS" -g -O0'
CCFLAGS='CC='"$cc"' CFLAGS="'"$COMPILE_FLAGS"'" CXX='"$cxx"' CXXFLAGS="'"$COMPILE_FLAGS"'"'
LDFLAGS='LDFLAGS="'"$LINK_FLAGS"'"'
LIB_LDFLAGS='LDFLAGS="'"$COMPILE_FLAGS"'"'

if [ "$no_link" = "true" ]; then
    ALL_FLAGS="$MAKE_FLAGS $CCFLAGS $LIB_LDFLAGS"
else
    ALL_FLAGS="$MAKE_FLAGS $CCFLAGS $LDFLAGS"
fi

build="make $ALL_FLAGS $target"
eval $build
