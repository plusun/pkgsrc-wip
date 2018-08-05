#!/bin/sh

usage() {
    echo "Usage: $0 libFuzzer|AFL|honggfuzz|Radamsa sanitizers|none single-file-source"
}

if [ "$#" -ne 3 ]; then
    usage
    exit 1
fi

fuzzer=$1
sanitizers=$2
file=$3
main=main.cpp

if [ $file = $main ]; then
    echo "File name conflict, please rename ${file}"
    exit 1
fi

create_main() {
    cat <<EOF > $main
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
int main(int argc, char *argv[]) {
    FILE *f = fopen(argv[1], "rb");
    fseek(f, 0, SEEK_END);
    size_t fsize = ftell(f);
    fseek(f, 0, SEEK_SET);

    uint8_t *buffer = (uint8_t *)malloc(fsize);
    fread(buffer, fsize, 1, f);
    fclose(f);

    return LLVMFuzzerTestOneInput(buffer, fsize);
}
EOF
}

if [ $fuzzer != "libFuzzer" ]; then
    create_main
fi

target="fuzz-me"

compile_source() {
    rm $target
    sanflag=
    if [ $sanitizers != "none" ]; then
	sanflag=$sanitizers
    fi
    if [ "$fuzzer" = "libFuzzer" ] && [ ! -z "$sanflag" ]; then
	sanflag=","$sanflag
    fi
    case $fuzzer in
	libFuzzer)
	    clang++ -fsanitize=fuzzer$sanflag -Wall -Werror -o $target $file
	    ;;
	AFL)
	    afl-clang++ -fsanitize=$sanflag -Wall -Werror -o $target $file $main
	    ;;
	honggfuzz)
	    #hfuzz-clang++ -fsanitize=$sanflag -Wall -Werror -fsanitize-coverage=trace-pc-guard,inline-8bit-counters,pc-table,trace-pc -o $target $file $main
	    hfuzz-clang++ -fsanitize=$sanflag -Wall -Werror -o $target $file $main
	    ;;
	Radamsa)
	    clang++ -fsanitize=$sanflag -Wall -Werror -o $target $file $main
	    ;;
	*)
	    echo "Unsupported fuzzer"
	    exit 1
    esac
}

seed=19950109

fuzz() {
    case $fuzzer in
	libFuzzer)
	    rm -rf libFuzzer-input
	    mkdir libFuzzer-input
	    # echo $seed > libFuzzer-input/seed
	    ./$target -seed=$seed libFuzzer-input
	    ;;
	AFL)
	    rm -rf afl-input
	    rm -rf afl-output
	    mkdir afl-input
	    mkdir afl-output
	    echo $seed > afl-input/seed
	    afl-fuzz -d -i afl-input -o afl-output -m none -t 300+ -- ./$target @@
	    ;;
	honggfuzz)
	    rm -rf hongg-input
	    mkdir hongg-input
	    echo $seed > hongg-input/seed
	    honggfuzz -f hongg-input --exit_upon_crash -- ./$target ___FILE___
	    ;;
	Radamsa)
	    echo abc > radamsa-input
	    while true; do
		radamsa -s $seed radamsa-input > radamsa-input
		./$target radamsa-input
		test $? -ne 0 && break
	    done
	    ;;
	*)
	    echo "Unsupported fuzzer"
	    exit 1
    esac
}

compile_source
start=$(date +%s)
echo $start
fuzz
end=$(date +%s)
echo $end
t=$(( $end - $start ))

echo $t
