#!/usr/bin/env bash

set -euo pipefail

for kind in configmap serviceaccounts deployments; do
  echo "setting annotations and labels on $kind/coredns"
  kubectl -n kube-system annotate --overwrite $kind coredns meta.helm.sh/release-name=coredns
  kubectl -n kube-system annotate --overwrite $kind coredns meta.helm.sh/release-namespace=kube-system
  kubectl -n kube-system label --overwrite $kind coredns app.kubernetes.io/managed-by=Helm
done
