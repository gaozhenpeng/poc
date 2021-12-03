# poc
proof of concept

```bash
cd ~
k3d version
k3d cluster create poc
kubectl cluster-info
kubectl cluster-info dump

k3d cluster list
k3d cluster start poc
kubectl get pods -A

k3d cluster stop poc
k3d cluster delete poc

# compose
docker network create poc
```
