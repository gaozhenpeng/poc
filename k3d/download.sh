wget https://github.com/rancher/k3d/releases/download/v3.3.0/k3d-linux-amd64
mv k3d-linux-amd64 k3d
chmod +x k3d


# download kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl



wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
tar -xvzf helm-v3.3.4-linux-amd64.tar.gz
rm helm-v3.3.4-linux-amd64.tar.gz
mv linux-amd64/helm helm3
chmod +x helm3
rm -fr linux-amd64
