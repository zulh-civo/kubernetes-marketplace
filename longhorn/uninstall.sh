#!/bin/sh

kubectl patch storageclass longhorn -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# https://longhorn.io/docs/1.0.0/deploy/uninstall/#uninstalling-longhorn-using-kubectl
kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.0.0/uninstall/uninstall.yaml && \
  kubectl wait --for=condition=complete job/longhorn-uninstall && \
  kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.0.0/uninstall/uninstall.yaml && \
  kubectl get crds | grep longhorn | cut -d' ' -f1 | xargs -I % sh -c 'kubectl delete crd %'
