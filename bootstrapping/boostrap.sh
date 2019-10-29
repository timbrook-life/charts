#!/bin/bash

# ensure your bootstrapping the right thing
kubectl config get-contexts

read -p "Is the right cluster selected? "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Setup helm
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller

helm init --wait --upgrade --service-account tiller
helm version

kubectl create namespace core
kubectl create namespace build

# install Consul
helm upgrade -i consul -f ./consul_values.yaml stable/consul --namespace=core

# read -p "Press enter when consul is ready..."

# install traefik as ingress controller
helm upgrade -i traefik -f ./traefik_values.yaml stable/traefik --namespace=core

# read -p "Press enter when traefik is ready..."

# install vault, custom container
# TBD
helm upgrade -i vault -f ./vault_values.yaml personal/vault

# read -p "Press enter when vault is ready..."

# Build system
helm upgrade -i concourse -f ./concourse_values.yaml stable/concourse --namespace=build
