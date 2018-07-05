#!/bin/sh

usage() {
    echo "Usage: $0 cc cxx fuzzer netbsd_destdir netbsd_src_dir sanitizers|none"
    echo "Examples:"
    echo "  $0 afl-clang afl-clang++ afl-fuzz /path/to/destdir /path/to/src address,undefined"
    echo "  $0 hfuzz-clang hfuzz-clang++ honggfuzz /path/to/destdir /path/to/src none"
    echo
    echo "Attention: For honggfuzz, the compiling tools will be dependant on"
    echo "cc, please make sure it is available in search path. If you want to"
    echo "compile with sanitizers, please make sure cc supports them."
}

if [ "$#" -lt 6 ]; then
    usage
    exit 1
fi

cc=$1
cxx=$2
fuzzer=$3
destdir=`readlink -f $4`
src=`readlink -f $5`
sanitizers=$6
re=`readlink -f ./re.sh`
tool=`readlink -f ./build-one-afl-honggfuzz.sh`

build() {
    dir=$1
    (cd $dir && $re $tool $cc $cxx $destdir $sanitizers)
}

update_branch() {
    branch=$1
    (cd $src && git fetch && git checkout $branch && git pull)
}

check_command() {
    cmd=$1
    echo -n $cmd": " && command -v $cmd || \
	    { echo "missing"; exit 1; }
}

install_fuzzer() {
    check_command $fuzzer
    path=`command -v $fuzzer`
    base=$(dirname "$path")

    case $fuzzer in
	afl-fuzz)
	;;
	honggfuzz)
	;;
	*)
	    echo "Unsupported fuzzer type."
	    exit 1
    esac
    echo "Please use ldd $path to check dependant libraries and"
    echo "make sure they are under $destdir."

    mkdir -p $destdir$base
    cp $path $destdir/$base
}

set -e
set -x
