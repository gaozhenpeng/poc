# keycloak
- https://github.com/keycloak/keycloak-containers
- https://github.com/bitnami/bitnami-docker-postgresql
- https://github.com/codecentric/helm-charts/tree/master/charts/keycloak
- https://github.com/keycloak/keycloak/tree/main/examples/ldap
- https://artifacthub.io/packages/helm/codecentric/keycloak/15.0.0
- https://github.com/codecentric/helm-charts/tree/master/charts/keycloak
- https://github.com/codecentric/helm-charts/blob/master/charts/keycloak/values.yaml

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/openldap
helm install openldap ./chart --values values.yml --wait

cd /vagrant/keycloak
helm install keycloak codecentric/keycloak --version=15.1.0 --wait -f values.yml

helm uninstall openldap
helm uninstall keycloak

k3d cluster stop poc
```
