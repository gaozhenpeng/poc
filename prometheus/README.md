# prometheus
- https://prometheus.io/docs/prometheus/latest/installation/
- https://hub.docker.com/r/prom/prometheus/
- https://prometheus.io/docs/prometheus/latest/getting_started/
- https://github.com/prometheus-community/helm-charts/
- https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

```bash
# compose
# wait for own health metrics collection
# http://127.0.0.1:9090/metrics

# execute exporession:
# prometheus_target_interval_length_seconds
# prometheus_target_interval_length_seconds{quantile="0.99"}
# count(prometheus_target_interval_length_seconds)
# rate(prometheus_tsdb_head_chunks_created_total[1m])

k3d cluster start poc
kubectl get pods -A

cd /vagrant/prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus --wait -f values.yml

helm uninstall premetheus
k3d cluster stop poc
```
