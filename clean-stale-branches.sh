#!/bin/bash

######################################################################################
# This script will generate a list of old, and stale branches you can safely delete. #
# If you pass the mode (param #1) as "ALLSTALE" it will recursively delete on remote #
# for all stale branches. Otherwise, specify MODE as either:												 #
# (a) years																																					 #
# (b) year																																					 #
# (c) month																																					 #
# (d) months																																				 #
# Then specify time limit (param #2) as a number, ie: 3															 #
######################################################################################

MODE=$1
TIMELIMIT=$2

if [ "$#" -ne 2 ]; then
	echo "$0 MODE(ALLSTALE/YEARS/YEAR/MONTH/MONTHS) TIMELIMIT(1/2/3/4/5/6/7/8/9)"
	echo "Example:"
	echo "$0 ALLSTALE 3"
	exit 1
fi

set -e

for branch in `git branch -r --merged | grep -v HEAD`; do 
	TIME=`git show --format="%ci %cr %an" $branch | head -n 1`
	BRANCH_NAME=$branch
	BRANCH_NAME_NOORIGIN=`echo $BRANCH_NAME | awk -F '/' {'print $2'}`
	INPUT_AMOUNT=`echo $TIME | awk -F ' ' {'print $4'}`
	INPUT_PERIOD=`echo $TIME | awk -F ' ' {'print $5'}`
	if [ "$MODE" == "ALLSTALE" ]; then
		if [ "$INPUT_PERIOD" == "years" ]; then
			echo $BRANCH_NAME_NOORIGIN
		fi
		if [ "$INPUT_PERIOD" == "year" ]; then
			echo $BRANCH_NAME_NOORIGIN
		fi
		if  [ "$INPUT_AMOUNT" -gt "3" ]; then
			echo $BRANCH_NAME_NOORIGIN
		fi
	fi
	if [ "$MODE" == "years" ]; then
		if [ "$INPUT_PERIOD" == "years" ]; then
			echo $BRANCH_NAME_NOORIGIN
		fi
	fi
	if [ "$MODE" == "months" ]; then
		if [ "$INPUT_PERIOD" -gt "$TIMELIMIT" ]; then
			echo $BRANCH_NAME_NOORIGIN
		fi
	fi
done
