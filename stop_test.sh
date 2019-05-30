#!/bin/bash

pids=`ps -A | grep 'read'|awk '{print$1}'`
kill -15 $pids 2>/dev/null

pids=`ps -A | grep dd |awk '{print$1}'`
kill -15 $pids 2>/dev/null
