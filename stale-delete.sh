#!/bin/bash

BRANCH_NAME=$1

if [ "$#" -ne 1 ]; then
	echo "$0 BRANCH_NAME"
	exit 1
fi

git push -d origin $BRANCH_NAME
git branch -d $BRANCH_NAME
