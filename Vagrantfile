# https://app.vagrantup.com/boxes

Vagrant.configure("2") do |config|

  config.vm.define "poc" do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.hostname = "poc"
    config.vm.box_check_update = false
    config.vm.network "private_network", ip: "192.168.56.222"
    config.vm.synced_folder '.', '/vagrant', disabled: false
    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 4
      vb.memory = "8192"
      # disable logging
      vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
      # virt
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
    end

    config.vm.provision "shell", :inline => <<END
apt-get update

# docker
# https://docs.docker.com/engine/install/ubuntu/
apt-get install -y \
     ca-certificates \
     curl \
     gnupg \
     lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant

# compose
# https://docs.docker.com/compose/install/
curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# k3d
# https://k3d.io
# https://github.com/rancher/k3d/releases
curl -sL "https://github.com/rancher/k3d/releases/download/v5.1.0/k3d-linux-amd64" -o /usr/local/bin/k3d
chmod +x /usr/local/bin/k3d

# misc
apt-get install -y ldap-utils

# kvm
# https://help.ubuntu.com/community/KVM/Installation
apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
adduser vagrant libvirt
adduser vagrant kvm
# https://ubuntu.com/server/docs/virtualization-virt-tools
apt-get intsall -y virtinst

END
  end

end
