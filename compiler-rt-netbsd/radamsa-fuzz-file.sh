#!/bin/sh

export UBSAN_OPTIONS=halt_on_error=1
init_file=file.init.input
echo -n -e \\x48\\x00\\x49\\x00 > $init_file
file=file.input
echo "Fuzzing..."
while true
do
    radamsa $init_file > $file
    file $file 2>1 >/dev/null
    test $? -gt 127 && break
done

echo "Error encountered"
echo "Please refer to $file under current directory"
