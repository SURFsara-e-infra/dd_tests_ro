#!/bin/bash

. config

tpr=0
for file in ioread*
do 
seconds=`cat $file | grep 'bytes copied' | awk '{print $7}'`
bytes=`cat $file | grep 'bytes copied' | awk '{print $3}'`

ts=0
for s in $seconds
do 
   ts=`python -c "print str($s+$ts)"`
done

bs=0
for b in $bytes
do 
   bs=`python -c "print str($b+$bs)"`
done

t=`python -c "print str($bs/($ts*1024*1024))"`

echo "read: $t"
tpr=`python -c "print str($t+$tpr)"`
done

echo avg throughput reads: $tpr MiB/s
echo
echo sum: `python -c "print str($tpr)"` MiB/s
