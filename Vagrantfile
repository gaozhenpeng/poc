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
sudo apt-get update
sudo apt-get install -y unzip


# docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y \
     ca-certificates \
     curl \
     gnupg \
     lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant

# compose
# https://docs.docker.com/compose/install/
sudo curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# k3d
# https://k3d.io
# https://github.com/rancher/k3d/releases
sudo curl -sL "https://github.com/rancher/k3d/releases/download/v5.1.0/k3d-linux-amd64" -o /usr/local/bin/k3d
sudo chmod +x /usr/local/bin/k3d

# misc
sudo apt-get install -y ldap-utils


# kvm
# https://help.ubuntu.com/community/KVM/Installation
sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser vagrant libvirt
sudo adduser vagrant kvm


# dotfiles
cd ~
git clone https://github.com/janmaghuyop/dotfiles.git
cd dotfiles
. link.sh
rm ~/.tmux.conf


# bin
cd ~
git clone https://github.com/janmaghuyop/bin.git
cd bin
. download.sh
END
  end

end
