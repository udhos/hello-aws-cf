#!/bin/bash

die() {
	echo >&2 $0: $@
	exit 1
}

echo KEYNAME=[$KEYNAME]

[ -n "$KEYNAME" ] || die missing KEYNAME

aws cloudformation create-change-set --stack-name demo-web --change-set-name changeSetNewKey \
	--use-previous-template \
	--parameters ParameterKey=VPCName,UsePreviousValue=true ParameterKey=KeyName,ParameterValue=$KEYNAME

