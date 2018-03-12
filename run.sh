#!/bin/bash

for line in `./clean-stale-branches.sh ALLSTALE 3 | sort`; do
    ./stale-delete.sh $line
done
