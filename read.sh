#!/bin/bash

OF=/dev/null

declare -a file_array

. config

MiB=1048576

trap 'exit 0;' INT
trap 'exit 0;' TERM

nfiles=`ls -1 ${READDIR}/${PREFIX}* | wc -l`

file_array=( $(ls ${READDIR}/${PREFIX}*) )

i=0
while [ 1 ]
do
i=`expr $i + 1`
a=`expr ${RANDOM} \* ${nfiles}`
c=`expr $a / 32768`

echo "read $i: dd if=${file_array[$c]} of=$OF bs=$BS"
t0=`python -c "import time; print time.time()"`
dd if=${file_array[$c]} of=$OF bs=$BS
t1=`python -c "import time; print time.time()"`
size=`stat -c '%s' ${file_array[$c]}`
size_MiB=`python -c "print float($size)/$MiB"`

seconds=`python -c "print $t1 - $t0"`
rate=`python -c "print $size_MiB/$seconds"`
echo read ${i}: $size bytes copied in $seconds seconds, $rate MiB/s

done
