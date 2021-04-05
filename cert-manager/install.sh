#!/bin/bash
# https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io

helm repo update

kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.crds.yaml

helm upgrade --install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.1.0
