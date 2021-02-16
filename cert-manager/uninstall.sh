#!/bin/bash
# https://cert-manager.io/docs/installation/uninstall/kubernetes/#uninstalling-with-helm

# Delete the app
helm --namespace cert-manager delete cert-manager

# Delete the custom CRDs
kubectl delete -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.crds.yaml

# Delete the namespace
kubectl delete namespace cert-manager
