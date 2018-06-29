#!/bin/sh

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 netbsd_destdir llvm_bin_dir netbsd_src_dir sanitizers"
    exit 1
fi

destdir=`readlink -f $1`
llvm_bin=`readlink -f $2`
src=`readlink -f $3`
sanitizers=$4
re=`readlink -f ./re.sh`
tool=`readlink -f ./build-one-fuzzer.sh`

set -e
set -x

build_target() {
    dir=$1
    no_link=$2
    (cd $dir && $re $tool $destdir $llvm_bin $no_link $sanitizers)
}

build_lib() {
    build_target $1 true
}

build_bin() {
    build_target $1 false
}

update_branch() {
    branch=$1
    (cd $src && git fetch && git checkout $branch && git pull)
}
