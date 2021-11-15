# rke
- https://kubernetes.io/docs/setup/best-practices/cluster-large
- https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/production/nodes-and-roles
- https://www.adaltas.com/en/2020/02/04/install-debug-lxd-k8s
- https://github.com/corneliusweig/kubernetes-lxd#using-docker-and-kubernetes-on-zfs-backed-host-systems
- https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/production/recommended-architecture
- https://ubuntu.com/kubernetes/docs/install-local
- https://ubuntu.com/kubernetes/docs/operations
- https://ubuntu.com/kubernetes/docs/scaling


```bash
# ubuntu:18.04

# install lxd
sudo snap install lxd
lxd init

# create network
lxc network create lxdbr1 ipv4.address=10.0.0.1/24 ipv4.nat=true ipv6.address=none

# rke
wget https://github.com/rancher/rke/releases/download/v1.0.4/rke_linux-amd64
chmod +x rke_linux-amd64

. install.sh

# kubeconfig
export KUBECONFIG=$(pwd)/kube_config_cluster.yml
kubectl get nodes
kubectl get pods --all-namespaces

# https://rancher.com/docs/rancher/v4.x/en/troubleshooting/networking/
kubectl create -f ds_overlaytest.yml
# wait for containers to run
. overlay_test.sh
kubectl delete -f ds_overlaytest.yml

. delete.sh




# test

# start nginx
cd nginx
docker-compose up -d

# create external services using this docker network
docker network create --subnet 172.20.0.0/24 kubernetes

cd minio
docker-compose up -d
kubectl create -f endpoint.yml
kubectl create -f service.yml
kubectl create -f ingress.yml




# multipass
sudo snap install multipass

# create vms
for i in "1 2 3"; do
  multipass launch 18.04 --name n$i --cpus 2 --mem 4G --disk 10G
done

sudo cp -fv /var/snap/multipass/common/data/multipassd/ssh-keys/id_rsa keys/
multipass ls

n1=$(multipass ls | grep n1 | tr -s ' ' | cut -d ' ' -f 3)
n2=$(multipass ls | grep n2 | tr -s ' ' | cut -d ' ' -f 3)
n3=$(multipass ls | grep n3 | tr -s ' ' | cut -d ' ' -f 3)

# install lxd in vms
for n in "$n1 $n2 $n3"; do
  ssh -o "StrictHostKeyChecking no" -i keys/id_rsa ubuntu@$n bash <<EOF
sudo apt-get update -y
sudo snap install lxd
EOF

  # preseed lxd
  scp -o "StrictHostKeyChecking no" -i keys/id_rsa lxd_config.yml ubuntu@$n:/home/ubuntu
  ssh -o "StrictHostKeyChecking no" -i keys/id_rsa ubuntu@$n bash -c "cat lxd_config.yml | lxd init --preseed"
done

scp -o "StrictHostKeyChecking no" -i keys/id_rsa lxd_config.yml ubuntu@$n:/home/ubuntu
# vm
cat lxd_config.yml | lxd init --preseed


sudo su - -c "echo 524288 > /sys/module/nf_conntrack/parameters/hashsize"

# create container machines
# https://us.images.linuxcontainers.org
# rke0
ssh -o "StrictHostKeyChecking no" -i keys/id_rsa ubuntu@$n1
lxc init ubuntu:18.04 rke1 -p kubernetes
lxc network attach ens4 rke1 eth0 eth0
lxc config device set rke1 eth0 ipv4.address 10.0.0.10
lxc start rke0

# host
scp -o "StrictHostKeyChecking no" -i keys/id_rsa keys/rke.pub ubuntu@$n3:/home/ubuntu
# vm
multipass shell n3
lxc file push rke.pub rke0/root/.ssh/authorized_keys --mode 0700

lxc exec rke0 bash
chown -R root:root /root

# host
ssh -o "StrictHostKeyChecking no" -i keys/rke -p 22 root@10.21.243.41
ssh -o "StrictHostKeyChecking no" -i keys/rke -p 22 root@10.21.243.105
ssh -o "StrictHostKeyChecking no" -i keys/rke -p 22 root@10.21.243.211

mount --make-shared /
curl https://releases.rancher.com/install-docker/18.09.2.sh | sh
systemctl restart docker.service

# install rke
./rke_linux-amd64 up --config multipass_cluster.yml


export KUBECONFIG=$(pwd)/kube_config_multipass_cluster.yml
kubectl get nodes
kubectl get pods --all-namespaces
```
