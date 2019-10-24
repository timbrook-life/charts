#!/bin/bash
exec 3>&1 # make stdout available as fd 3 for the result
exec 1>&2 # redirect all output to stderr for logging

loadPayload() {
    payload=$(mktemp $TMPDIR/helm-resource-request.XXXXXX)
    cat >$payload <&0
}

args() {
    cat $payload
}

loadPayload
