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

