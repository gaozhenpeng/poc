# rancher
- https://github.com/rancher/rancher/
- https://rancher.com/docs/rancher/v2.x/en/installation/resources/choosing-version/
- https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_openldap
- https://github.com/rancher/rancher/tree/release/v2.6/chart
- https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/
- https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/chart-options/

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/openldap
helm install openldap ./chart --values values.yml --wait

cd /vagrant/rancher
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
helm install rancher rancher-latest/rancher --namespace cattle-system -f values.yml --wait

# expose
kubectl --namespace cattle-system port-forward --address 0.0.0.0 svc/rancher 8081:80
kubectl --namespace cattle-system port-forward --address 0.0.0.0 svc/rancher 8443:443

# visit 192.168.56.222:8081

helm uninstall openldap
helm -n cattle-system uninstall rancher

k3d cluster stop poc
```
