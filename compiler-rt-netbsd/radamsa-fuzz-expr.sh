#!/bin/sh

str=
while true
do
    str=`echo "1 + 1" | radamsa`
    expr $str
    test $? -gt 127 && break
done

echo $str
