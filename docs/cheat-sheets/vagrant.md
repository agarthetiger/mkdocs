# Vagrant
## Tips
### Ansible with Vagrant
To reuse Vagrant VMs as the target for Ansible automation development, you can use a git submodule to include the repo with the Vagrantfile. In the Vagrantfile include an ansible provisioner then the provisioner will create an Ansible Inventory in .vagrant/provisioners/ansible/inventory which can then be used as the Ansible inventory from playbooks under development on the  host, without having to copy/duplicate any files. 

Note that only the ansible provisioner creates this inventory, presumably because the provisioner itself is using this to provision the VMs from the host machine with Ansible. The ansible-local provisioner runs on the VMs so does not create an inventory on the Vagrant host.

Multiple provisioners can be specified in the Vagrantfile, the inventory trick with the Ansible provisioner can co-exist alongside configuration with the ansible-local provisioner to further provision the VMs on startup should this be required. Ideally the base box would be built with Packer so that no time-consuming customisation is required when starting the VMs. Yes, Docker would be much faster, however there are times when a VM more closely replicates the target environment for the Ansible automation and this is desirable.
