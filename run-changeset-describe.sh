#!/bin/bash

usage() {
        echo >&2 usage: $0 changeset-id
        echo >&2
        echo >&2 use run-changeset-list.sh to find the id
        exit 1
}

id="$1"

[ -n "$id" ] || usage

aws cloudformation describe-change-set --change-set-name "$id"

