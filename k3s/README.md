# k3s

```bash
# https://github.com/rancher/k3s
# https://rancher.com/docs/k3s/latest/en/installation/install-options/
# https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/#agent-networking
# https://rancher.com/docs/k3s/latest/en/installation/install-options/how-to-flags/

# https://rancher.com/docs/k3s/latest/en/installation/datastore/

# master, worker
sudo ufw allow 8472/udp
sudo ufw allow 10250


# https://github.com/rancher/k3s/releases
sudo su
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.17.14+k3s2 INSTALL_K3S_EXEC="--flannel-iface=enp0s8" sh -

# cluster access
# https://rancher.com/docs/k3s/latest/en/cluster-access/
systemctl status k3s
kubectl get nodes
kubectl get all --all-namespaces

# master creds
/etc/rancher/k3s/k3s.yaml

# install worker nodes
cat /var/lib/rancher/k3s/server/node-token # master node
sudo su
export K3S_URL="https://192.168.33.51:6443"
export K3S_TOKEN=""
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.17.14+k3s2 INSTALL_K3S_EXEC="--flannel-iface=enp0s8" K3S_URL=${K3S_URL} K3S_TOKEN=${K3S_TOKEN} sh -
systemctl status k3s-agent

# backup
/var/lib/rancher/k3s/server/db/state.db

# k3sup
https://github.com/alexellis/k3sup
https://nimblehq.co/blog/provision-k3s-on-google-cloud-with-terraform-and-k3sup


# upgrade
https://rancher.com/blog/2020/upgrade-k3s-kubernetes-cluster-system-upgrade-controller
https://rancher.com/docs/k3s/latest/en/upgrades/basic/
https://www.cncf.io/blog/2020/11/25/upgrade-a-k3s-kubernetes-cluster-with-system-upgrade-controller/


# delete node
# delete kubernetes node
kubectl get nodes
kubectl drain <node-name>
kubectl delete node <node-name>
```
