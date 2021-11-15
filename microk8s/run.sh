microk8s.start
sudo iptables -P FORWARD ACCEPT
microk8s.status --wait-ready
microk8s.inspect
microk8s.kubectl get pods --namespace kube-system
