# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook playbook.yml -i inv/dev
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook playbook.yml -i inv/pro -l workstation
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook playbook.yml -i inv/pro -l server

ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook xubuntu.yml -i inv/dev -l xubuntu
