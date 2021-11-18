# openldap
No official helm chart yet. \
DEPRECATED: https://github.com/helm/charts/tree/master/stable/openldap

#### docker
- https://github.com/osixia/docker-openldap
- https://hub.docker.com/r/osixia/openldap

#### managers
- https://github.com/osixia/docker-phpLDAPadmin
- https://github.com/LDAPAccountManager/lam
- https://github.com/wheelybird/ldap-user-manager
- https://github.com/osixia/docker-openldap-backup

```bash
helm install openldap ./chart --values values.yml --wait
kubectl port-forward \
  $(kubectl get pods --selector='release=openldap' -o jsonpath='{.items[0].metadata.name}') \
  5389:389
```
