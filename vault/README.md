# vault
- https://github.com/hashicorp/vault-helm

```bash
# compose
export VAULT_ADDR='http://127.0.0.1:8200'
vault status
vault login token

# kv
vault secrets enable -version=1 kv
vault kv put kv/secret1 key1=val2 key3=val3
vault kv put kv/secret2 key2=val2
vault kv get kv/secret1
vault kv get kv/secret2
vault kv list kv
vault kv delete kv/secret2

# ldap
vault auth enable ldap
vault write auth/ldap/config \
   url="ldap://ldap:389" \
   userattr="uid" \
   userdn="ou=devs,dc=example,dc=com" \
   binddn="cn=admin,dc=example,dc=com" \
   bindpass='password'

# poc
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
