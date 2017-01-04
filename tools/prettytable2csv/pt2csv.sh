#!/usr/bin/env bash

# Created by: Arash Morattab
# Made to handle ceilometer cli outputs
# Sample usage: ceilometer meter-list | ./pt2csv.sh

#    if [ $# -eq 0 ]; then
#        echo "Give me a pretty table through pipe."
#    else
while read x ; do echo $x | grep -v '\-\-\-\-' | sed 's/^[^|]\+|//g' | sed 's/|\(.\)/,\1/g' | tr '|' '\n' | sed 's/ //g' | sed '/^$/d' | cut -c 2- ; done
#    fi

