#!/bin/sh

export UBSAN_OPTIONS=halt_on_error=1
str=
echo "Fuzzing..."
while true
do
    str=`echo "1 + 1" | radamsa`
    expr $str 2>1 > /dev/null
    test $? -gt 127 && break
done

echo "Error encountered, input: "
echo $str
