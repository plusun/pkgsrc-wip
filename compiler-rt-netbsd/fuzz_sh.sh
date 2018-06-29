#!/bin/sh

. ./fuzzer_header.sh

# switch to `fuzzer-expr' branch and build with libFuzzer
update_branch fuzzer-expr
build_lib $src/lib/libterminfo
build_lib $src/lib/libedit
build_bin $src/bin/sh

# Make corpus and dict
chroot_corpus=/sh-corpus
chroot_dict=/sh-dict
corpus=$destdir$chroot_corpus
dict=$destdir$chroot_dict
mkdir -p $corpus
cat > $corpus/initial <<EOF
echo "hello, world!"
EOF
cat > $dict <<EOF
"echo"
"ls"
"cat"
"hostname"
"test"
"["
"]"
EOF
export UBSAN_OPTIONS=halt_on_error=1
echo "Please refer to sh-error.log for detailed output!"
chroot $destdir /bin/sh -only_ascii=1 -max_len=32 -dict=$chroot_dict $chroot_corpus 1>/dev/null 2>sh-error.log
