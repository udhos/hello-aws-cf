#!/bin/bash

die() {
	echo >&2 $0: $@
	exit 1
}

echo KEYNAME=[$KEYNAME]

[ -n "$KEYNAME" ] || die missing KEYNAME

aws cloudformation create-stack --stack-name demo-web --template-body file://template/web.yaml --parameters ParameterKey=VPCName,ParameterValue=vpc-demo-web ParameterKey=KeyName,ParameterValue=$KEYNAME
