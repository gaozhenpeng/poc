# jenkins
- https://hub.docker.com/r/jenkins/jenkins
- https://plugins.jenkins.io/role-strategy
- https://github.com/jenkinsci/configuration-as-code-plugin
- https://docs.openstack.org/infra/jenkins-job-builder
- https://hub.docker.com/r/jenkins/jnlp-slave/tags
- https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/openldap
helm install openldap ./chart --values values.yml --wait

cd /vagrant/jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins jenkins/jenkins --wait --version=3.4.0 -f values.yml

kubectl --namespace default port-forward --address 0.0.0.0 svc/jenkins 8080:8080

helm uninstall openldap
helm uninstall jenkins

k3d cluster stop poc
```
