#!/bin/bash
##
# Deploys new chart release into my helm repo
#
set -e -x

s3cmd get s3://helm-charts/index.yaml --force

# cat Chart.yaml | yq '''
#     . + {version: (.version
#     | split(".") as [$maj, $min, $patch]
#     | [$maj, $min, ($patch | tonumber) + 1]
#     | join(".") )}
# '''

helm package .
helm repo index --merge index.yaml .

s3cmd put -P appshell-*.tgz s3://helm-charts/ 
s3cmd put -P index.yaml s3://helm-charts/index.yaml 

rm appshell-*
rm index.yaml

helm repo update