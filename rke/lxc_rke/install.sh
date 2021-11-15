# kube-proxy fix
sudo su - -c "echo 524288 > /sys/module/nf_conntrack/parameters/hashsize"

# create lxc profile
lxc profile create kubernetes

# https://raw.githubusercontent.com/ubuntu/microk8s/master/tests/lxc/microk8s.profile
lxc profile edit kubernetes <<EOF
name: kubernetes
description: kubernetes

config:
  limits.memory.swap: "false"
  linux.kernel_modules: ip_tables,netlink_diag,nf_nat,overlay
  raw.lxc: |
    lxc.apparmor.profile=unconfined
    lxc.cap.drop=
    lxc.cgroup.devices.allow=a
    lxc.mount.auto=proc:rw sys:rw
  security.privileged: "true"
  security.nesting: "true"

devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr1
    type: nic
  root:
    path: /
    pool: default
    type: disk
  aadisable:
    path: /sys/module/nf_conntrack/parameters/hashsize
    source: /sys/module/nf_conntrack/parameters/hashsize
    type: disk
  aadisable1:
    path: /sys/module/apparmor/parameters/enabled
    source: /dev/null
    type: disk
  aadisable2:
    path: /dev/kmsg
    source: /dev/kmsg
    type: disk
EOF



# create container machines
# https://us.images.linuxcontainers.org
# rke0
lxc init images:centos/7/amd64 rke0 -p kubernetes
lxc network attach lxdbr1 rke0 eth0 eth0
lxc config device set rke0 eth0 ipv4.address 10.0.0.10

# rke1
lxc init images:centos/7/amd64 rke1 -p kubernetes
lxc network attach lxdbr1 rke1 eth0 eth0
lxc config device set rke1 eth0 ipv4.address 10.0.0.11

# rke2
lxc init images:centos/7/amd64 rke2 -p kubernetes
lxc network attach lxdbr1 rke2 eth0 eth0
lxc config device set rke2 eth0 ipv4.address 10.0.0.12



# start machines
lxc start rke0 rke1 rke2
sleep 5



# install ssh
nodes="rke0 rke1 rke2"

for node in ${nodes[@]}
do
sleep 5
lxc exec $node bash <<-EOF
# dns
echo "nameserver 1.1.1.1" > /etc/resolv.conf

# ssh
yum -y install openssh-server
sed -i 's/#PermitRootLogin yes/PermitRootLogin without-password/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config
chkconfig sshd on
service sshd start

# rke user
useradd -m rke -s /bin/bash
mkdir /home/rke/.ssh && chmod 700 /home/rke/.ssh
mkdir /root/.ssh && chmod 700 /root/.ssh
EOF

# put ssh pubkey
lxc file push keys/rke.pub ${node}/root/.ssh/authorized_keys --mode 0700
lxc file push keys/rke.pub ${node}/home/rke/.ssh/authorized_keys --mode 0700

lxc exec $node bash <<-EOF
chown -R root:root /root
chown -R rke:rke /home/rke
EOF
done

ssh-keygen -f "/home/prawn/.ssh/known_hosts" -R "10.0.0.10"
ssh-keygen -f "/home/prawn/.ssh/known_hosts" -R "10.0.0.11"
ssh-keygen -f "/home/prawn/.ssh/known_hosts" -R "10.0.0.12"

ssh -o "StrictHostKeyChecking no" -i keys/rke rke@10.0.0.10 'hostname'
ssh -o "StrictHostKeyChecking no" -i keys/rke rke@10.0.0.11 'hostname'
ssh -o "StrictHostKeyChecking no" -i keys/rke rke@10.0.0.12 'hostname'

# install docker
for node in ${nodes[@]}
do
	lxc exec $node bash <<-EOF
    # fix
    mount --make-shared /
    # restart fix
    crontab -l | { cat; echo "@reboot mount --make-shared / && systemctl start docker.service"; } | crontab -

    # https://rancher.com/docs/rke/latest/en/os/#installing-docker
    curl https://releases.rancher.com/install-docker/18.09.2.sh | sh

    # add user to docker group
    usermod -aG docker rke

    systemctl daemon-reload
    systemctl restart docker.service
	EOF
done


# install rke
./rke_linux-amd64 up

