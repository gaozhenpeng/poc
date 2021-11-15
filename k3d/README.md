# k3d
https://k3d.io
https://github.com/rancher/k3d/releases
https://k3d.io/usage/commands/



```bash
# spinnaker

./k3d cluster create spinnaker -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get spinnaker > spinnaker_kubeconfig export KUBECONFIG=$(pwd)/spinnaker_kubeconfig
./kubectl create ns spinnaker


# https://artifacthub.io/packages/helm/minio/minio
./helm3 repo add minio https://helm.min.io
./helm3 repo update
./helm3 show values minio/minio > minio.yaml
./helm3 install --namespace spinnaker minio minio/minio --version 8.0.5 -f minio.yaml


# https://artifacthub.io/packages/helm/spinnaker/spinnaker
./helm3 repo add spinnaker https://helmcharts.opsmx.com
./helm3 repo update
./helm3 show values spinnaker/spinnaker > spinnaker.yaml
./helm3 install --namespace spinnaker spinnaker spinnaker/spinnaker --version 2.2.3 -f spinnaker.yaml --timeout 600s


export DECK_POD=$(./kubectl get pods --namespace spinnaker -l "cluster=spin-deck" -o jsonpath="{.items[0].metadata.name}")
./kubectl port-forward --namespace spinnaker $DECK_POD 9000

export GATE_POD=$(./kubectl get pods --namespace spinnaker -l "cluster=spin-gate" -o jsonpath="{.items[0].metadata.name}")
./kubectl port-forward --namespace spinnaker $GATE_POD 8084

# visit http://127.0.0.1:9000








# jenkins
# https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins

./k3d cluster create jenkins -s 1 -a 1 -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get jenkins > jenkins_kubeconfig
export KUBECONFIG=$(pwd)/jenkins_kubeconfig
./kubectl create ns jenkins

# https://artifacthub.io/packages/helm/jenkinsci/jenkins
./helm3 repo add jenkinsci https://charts.jenkins.io/
./helm3 repo update
./helm3 show values jenkinsci/jenkins > jenkins.yaml
./helm3 install --namespace jenkins jenkins jenkinsci/jenkins --version 3.0.2 -f jenkins.yaml

./kubectl --namespace jenkins port-forward svc/jenkins 8080:8080
# visit http://127.0.0.1:8080

# start
./k3d cluster start jenkins
./k3d kubeconfig get jenkins > jenkins_kubeconfig
export KUBECONFIG=$(pwd)/jenkins_kubeconfig
./k3d cluster stop jenkins







# elk
./k3d cluster create elastic -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get elastic > elastic_kubeconfig
export KUBECONFIG=$(pwd)/elastic_kubeconfig
./kubectl create ns elastic

# https://artifacthub.io/packages/helm/elastic/elasticsearch
./helm3 repo add elastic https://helm.elastic.co
./helm3 repo update
./helm3 show values elastic/elasticsearch > elasticsearch.yaml
./helm3 install --namespace elastic elasticsearch elastic/elasticsearch --version 7.10.0 -f elasticsearch.yaml

./helm3 show values elastic/kibana > kibana.yaml
./helm3 install --namespace elastic kibana elastic/kibana --version 7.10.0 -f kibana.yaml
./kubectl --namespace elastic port-forward svc/kibana-kibana 5601:5601
# visit http://127.0.0.1:5601





# rabbitmq
./k3d cluster create rabbitmq -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get rabbitmq > rabbitmq_kubeconfig
export KUBECONFIG=$(pwd)/rabbitmq_kubeconfig
./kubectl create ns rabbitmq

# https://artifacthub.io/packages/helm/bitnami/rabbitmq
./helm3 repo add bitnami https://charts.bitnami.com/bitnami
./helm3 repo update
./helm3 show values bitnami/rabbitmq > rabbitmq.yaml
./helm3 install --namespace rabbitmq rabbitmq bitnami/rabbitmq --version 8.2.0 -f rabbitmq.yaml
./kubectl port-forward --namespace rabbitmq svc/rabbitmq 15672:15672
# visit http://127.0.0.1:15672






# redis
./k3d cluster create redis -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get redis > redis_kubeconfig
export KUBECONFIG=$(pwd)/redis_kubeconfig
./kubectl create ns redis

./helm3 repo add bitnami https://charts.bitnami.com/bitnami
./helm3 repo update
./helm3 show values bitnami/redis > redis.yaml
./helm3 install --namespace redis redis bitnami/redis --version 12.1.1 -f redis.yaml







# mariadb
./k3d cluster create mariadb -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get mariadb > mariadb_kubeconfig
export KUBECONFIG=$(pwd)/mariadb_kubeconfig
./kubectl create ns mariadb

./helm3 repo add bitnami https://charts.bitnami.com/bitnami
./helm3 repo update
./helm3 show values bitnami/mariadb > mariadb.yaml
./helm3 install --namespace mariadb mariadb bitnami/mariadb --version 9.0.1 -f mariadb.yaml










# minio
./k3d cluster create minio -i rancher/k3s:v1.17.14-k3s2
./k3d kubeconfig get minio > minio_kubeconfig
export KUBECONFIG=$(pwd)/minio_kubeconfig
./kubectl create ns minio

./helm3 repo add minio https://helm.min.io/
./helm3 repo update
./helm3 show values minio/minio > minio.yaml
./helm3 install --namespace minio minio minio/minio --version 8.0.5 -f minio.yaml
```
