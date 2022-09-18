#!/bin/bash

set -e

k3d-create() {
  k3d cluster create a-lab \
    --servers 1 \
    --agents 3 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker:/var/lib/docker \
    --port 80:80@loadbalancer \
    --port 443:443@loadbalancer \
    --api-port 6443 \
    --k3s-arg "--disable=traefik@server:0" \
    --kubeconfig-update-default \
    --registry-config "./registry/registry.yaml"
}

k3d-destroy() {
  k3d cluster delete a-lab
}

istio-create() {
  kubectl create ns istio-system --dry-run=true -o yaml | kubectl apply -f -
  kubectl apply -f istio/manifest.yaml
  #kustomize build certificates | kubectl apply -f -
  #kustomize build istio-bells | kubectl apply -f - 
}

$1
