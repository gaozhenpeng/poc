# get ssh key
sudo cp -fv /var/snap/multipass/common/data/multipassd/ssh-keys/id_rsa .
sudo chown $USER:$USER id_rsa

# create vms
nodes=(n1 n2 n3)
for n in ${nodes[@]}; do
  echo $n
  multipass launch 18.04 --name $n --cpus 2 --mem 4G --disk 10G
done

# wait for dhcp lease
sleep 10

# get vm ips
n1=$(multipass ls | grep n1 | tr -s ' ' | cut -d ' ' -f 3)
n2=$(multipass ls | grep n2 | tr -s ' ' | cut -d ' ' -f 3)
n3=$(multipass ls | grep n3 | tr -s ' ' | cut -d ' ' -f 3)

# install lxd in vms
ips=($n1 $n2 $n3)
for ip in ${ips[@]}; do
  ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$ip <<EOF
sudo apt-get update -y
sudo snap install lxd
EOF

  # preseed lxd config
  scp -o "StrictHostKeyChecking no" -i id_rsa lxd_config.yml ubuntu@$ip:/home/ubuntu
  ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$ip "cat lxd_config.yml | lxd init --preseed"

  # create container machine
  ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$ip <<EOF

# kube-proxy fix
#sudo su - -c "echo 524288 > /sys/module/nf_conntrack/parameters/hashsize"

lxc init ubuntu:18.04 rke -p kubernetes
lxc start rke
EOF

  # copy rke public key
  scp -o "StrictHostKeyChecking no" -i id_rsa ../keys/rke.pub ubuntu@$ip:/home/ubuntu
  ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$ip "lxc file push rke.pub rke/root/.ssh/authorized_keys --mode 0700"
  ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$ip "lxc exec rke -- chown -R root:root /root"
done

# get rke ips
r1=$(ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$n1 "lxc ls | grep rke | cut -d ' ' -f 7")
r2=$(ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$n2 "lxc ls | grep rke | cut -d ' ' -f 7")
r3=$(ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@$n3 "lxc ls | grep rke | cut -d ' ' -f 7")

# install docker in container
ips=($r1 $r2 $r3)
for ip in ${ips[@]}; do
  ssh -o "StrictHostKeyChecking no" -i ../keys/rke root@$ip <<EOF
mount --make-shared /
curl https://releases.rancher.com/install-docker/18.09.2.sh | sh
systemctl restart docker.service
EOF
done

# edit cluster.yml
ips=($r1 $r2 $r3)
for ip in ${ips[@]}; do
  echo $ip
done

# install rke
#../rke_linux-amd64 up --config cluster.yml

