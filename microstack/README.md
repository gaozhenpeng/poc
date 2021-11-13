# microstack

```bash
# openstack
https://docs.openstack.org/ussuri/

# microstack
# https://ubuntu.com/tutorials/microstack-get-started

sudo snap install microstack --devmode --beta
sudo snap enable microstack
sudo microstack init --auto --control

http://10.20.20.1/
username: admin
# password
sudo snap get microstack config.credentials.keystone-password


# https://docs.openstack.org/nova/pike/admin/quotas.html
microstack.openstack quota show --default
microstack.openstack quota set --instances 15 default
PROJECT=admin
microstack.openstack quota show $PROJECT


microstack.openstack image list
microstack.openstack image show cirros
# https://docs.openstack.org/ocata/user-guide/common/cli-manage-images.html
# http://cloud-images.ubuntu.com/focal/current/
wget http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
microstack.openstack image create --disk-format qcow2 --container-format bare \
  --public --file ./focal-server-cloudimg-amd64.img ubuntu2004
microstack.openstack image list


# https://releases.hashicorp.com/terraform/
# https://www.terraform.io/downloads.html
wget https://releases.hashicorp.com/terraform/0.15.1/terraform_0.15.1_linux_amd64.zip
unzip terraform*.zip
rm terraform*.zip


# https://docs.openstack.org/nova/pike/admin/flavors2.html
microstack.openstack flavor list
microstack.openstack flavor create g1.small --id auto --ram 1792 --disk 10 --vcpus 1


microstack.openstack keypair create terraform > terraform_key
microstack.openstack keypair list

./terraform init
./terraform plan
./terraform apply

chmod 600 terraform_key
ssh -o "StrictHostKeyChecking=no" -i terraform_key ubuntu@10.20.20.50

sudo snap disable microstack

# clean
rm -fr terraform.tfstate
rm -fr terraform.tfstate.backup
```
