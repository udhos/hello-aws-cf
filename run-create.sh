#!/bin/bash

aws cloudformation create-stack --stack-name demo-web --template-body file://template/web.yaml --parameters ParameterKey=VPCName,ParameterValue=vpc-demo-web
