#!/bin/bash

TESTDIR=`pwd`

seq () {
    i=$1
    s=""
    while [ $i -le $2 ]
    do
        s=$s"$i "
        i=`expr $i + 1`
    done
    echo $s
}

usage () {
    echo "start_tests.sh <number of concurrent read operations>" 1>&2
}

if [ $# -ne 1 ]; then
   usage
   exit 1
fi

IOS=$1

rm -f ioread* 

for i in `seq 1 $IOS`
do
    $TESTDIR/read.sh > $TESTDIR/ioread${i}1 2>&1 &
done
