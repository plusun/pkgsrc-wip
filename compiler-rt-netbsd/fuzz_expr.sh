#!/bin/sh

. ./fuzzer_header.sh

# switch to `fuzzer-expr' branch and build with libFuzzer
update_branch fuzzer-expr
build_bin $src/bin/expr

# Make corpus and dict
chroot_corpus=/expr-corpus
chroot_dict=/expr-dict
corpus=$destdir$chroot_corpus
dict=$destdir$chroot_dict
mkdir -p $corpus
echo "1 / 2" > $corpus/initial
cat > $dict <<EOF
min="-9223372036854775808"
max="9223372036854775807"
zero="0"
one="1"
negone="-1"
div="/"
mod="%"
add="+"
sub="-"
or="|"
add="&"
EOF
export UBSAN_OPTIONS=halt_on_error=1
chroot $destdir /bin/expr -only_ascii=1 -max_len=32 -dict=$chroot_dict $chroot_corpus >/dev/null
