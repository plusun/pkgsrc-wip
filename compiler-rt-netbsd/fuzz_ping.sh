#!/bin/sh

. ./fuzzer_header.sh

# switch to `fuzzer-expr' branch and build with libFuzzer
update_branch fuzzer-expr
build_lib $src/lib/libipsec
build_bin $src/sbin/ping

# Make corpus and dict
chroot_corpus=/ping-corpus
corpus=$destdir$chroot_corpus
mkdir -p $corpus
export UBSAN_OPTIONS=halt_on_error=1
chroot $destdir /sbin/ping $chroot_corpus >/dev/null
