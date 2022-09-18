# k3d registry create registry.localhost --port 5500
# docker network connect k3d k3d-registry.localhost
# k3d cluster create test-multi-node --servers 1 --agents 2 --port 9080:80@loadbalancer --port 9443:443@loadbalancer --api-port 6443  --k3s-arg "--disable=traefik@server:0"
