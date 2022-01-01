sudo snap disable lxd

sudo systemctl stop snapd.service
sudo systemctl stop snapd.socket
sudo systemctl stop snapd.seeded
sudo systemctl stop snapd.snap-repair.timer

