#!/bin/bash

kubectl create ns loki

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm upgrade --install \
  loki grafana/loki-stack \
  --namespace loki \
  --version 0.41.2
