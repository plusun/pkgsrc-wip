#!/bin/sh

. ./fuzzer_header.sh

# switch to `fuzzer-expr' branch and build with libFuzzer
update_branch fuzzer-expr
build_bin $src/usr.bin/sed

# Make corpus and dict
chroot_corpus=/sed-corpus
chroot_dict=/sed-dict
corpus=$destdir$chroot_corpus
dict=$destdir$chroot_dict
mkdir -p $corpus
cat > $corpus/initial <<EOF
s/hello/hi/g

hello, world!
EOF
cat > $dict <<EOF
newline="\x0A"
"a\\\"
"b"
"c\\\"
"d"
"D"
"g"
"G"
"h"
"H"
"i\\\"
"l"
"n"
"N"
"p"
"P"
"q"
"t"
"x"
"y"
"!"
":"
"="
"#"
"/"
EOF
export UBSAN_OPTIONS=halt_on_error=1
chroot $destdir /usr/bin/sed -only_ascii=1 -max_len=128 -dict=$chroot_dict $chroot_corpus >/dev/null
