#!/bin/bash

aws cloudformation update-stack --stack-name demo-web --template-body file://template/web.yaml

