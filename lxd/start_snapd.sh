sudo systemctl start snapd.service
sudo systemctl start snapd.socket
sudo systemctl start snapd.seeded
sudo systemctl start snapd.snap-repair.timer

sudo snap enable lxd
