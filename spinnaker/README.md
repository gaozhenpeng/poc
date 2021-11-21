# spinnaker
- https://github.com/OpsMx/spinnaker-helm/blob/main/values.yaml

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/openldap
helm install openldap ./chart --values values.yml --wait

cd /vagrant/minio


cd /vagrant/spinnaker
helm repo add spinnaker https://helmcharts.opsmx.com/
helm install spinnaker spinnaker/spinnaker --timeout 3000s --version 2.2.7 -f values.yml

export DECK_POD=$(kubectl get pods -l "cluster=spin-deck" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --address 0.0.0.0 $DECK_POD 9000:9000

export GATE_POD=$(kubectl get pods -l "cluster=spin-gate" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --address 0.0.0.0 $GATE_POD 8084:8084

# Visit the Spinnaker UI by opening your browser to: http://127.0.0.1:9000
# To customize your Spinnaker installation. Create a shell in your Halyard pod:
kubectl exec -it spinnaker-spinnaker-halyard-0 bash

helm uninstall openldap
helm uninstall minio
helm uninstall spinnaker

k3d cluster stop poc
```
