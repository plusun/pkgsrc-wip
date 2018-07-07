#!/bin/sh

export UBSAN_OPTIONS=halt_on_error=1
str=
file=sed.input
echo "Fuzzing..."
while true
do
    str=`echo "hello, world!" | radamsa`
    echo $str > $file
    sed s/hello/hi/g $file  2>1 >/dev/null
    test $? -gt 127 && break
done

echo "Error encountered"
echo "Please refer to $file under current directory"
