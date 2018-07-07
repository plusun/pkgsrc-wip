#!/bin/sh

export UBSAN_OPTIONS=halt_on_error=1
str=
file=sh.input
echo "Fuzzing..."
while true
do
    str=`echo "echo hello, world!" | radamsa`
    echo $str > $file
    sh $file  2>1 >/dev/null
    test $? -gt 127 && break
done

echo "Error encountered"
echo "Please refer to $file under current directory"
