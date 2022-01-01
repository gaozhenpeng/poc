launch ubuntu:20.04 test
sudo apt install -y zfsutils-linux
sudo adduser prawn lxd # needs restart
sudo lxd init

lxc launch ubuntu:21.04 -p default test


sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded
sudo systemctl disable snapd.snap-repair.timer

sudo systemctl start snapd.service
sudo systemctl start snapd.socket
sudo systemctl start snapd.seeded
sudo systemctl start snapd.snap-repair.timer

sudo systemctl stop snapd.service
sudo systemctl stop snapd.socket
sudo systemctl stop snapd.seeded
sudo systemctl stop snapd.snap-repair.timer




# https://linuxcontainers.org/lxd/getting-started-cli/
# test
lxc profile create x11
cat x11.profile | lxc profile edit x11
lxc launch ubuntu:20.04 -p default -p x11 test
lxc exec test -- sudo --user ubuntu --login
# profile
lxc profile add <instance_name> <profile_name>
lxc profile add workspace x11
lxc profile remove workspace x11
lxc profile delete x11
lxc exec test -- sudo --user ubuntu --login




# gui
# https://blog.simos.info/how-to-easily-run-graphics-accelerated-gui-apps-in-lxd-containers-on-your-ubuntu-desktop/
lxc profile create x11
cat x11.profile | lxc profile edit x11
lxc launch ubuntu:20.04 --profile default --profile x11 gui
lxc exec gui -- sudo --user ubuntu --login

# check cloud init log
tail -6 /var/log/cloud-init.log


# kubernetes
https://ubuntu.com/blog/running-kubernetes-inside-lxd
https://github.com/corneliusweig/kubernetes-lxd

