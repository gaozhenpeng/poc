# vault
- https://github.com/hashicorp/vault-helm

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/openldap
helm install openldap ./chart --values values.yml --wait

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm install vault hashicorp/vault --wait --version=0.18.0 -f values.yml

kubectl --namespace default port-forward --address 0.0.0.0 svc/vault 8200:8200

helm uninstall openldap
helm uninstall vault

k3d cluster stop poc
```
