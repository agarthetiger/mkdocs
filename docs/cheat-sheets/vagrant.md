# Vagrant
## Tips
### Ansible with Vagrant
To reuse Vagrant VMs as the target for Ansible automation development, you can use a git submodule to include the repo with the Vagrantfile. In the Vagrantfile include an ansible provisioner then the provisioner will create an Ansible Inventory in .vagrant/provisioners/ansible/inventory which can then be used as the Ansible inventory from playbooks under development on the  host, without having to copy/duplicate any files. 

