## collection

* `ansible-galaxy collection build` - Build a collection, execute from the folder containing galaxy.yml
* `ansible-galaxy collection install my_namespace.my_collection:1.0.0` - Install version 1.0.0 from https://galaxy.ansible.com into ~/.ansible/collections
* `ansible-galaxy collection install my_namespace-my_collection-1.0.0.tar.gz -p ./collections` - Install from local tarball into local folder

## inventory

* `ansible-inventory -i <inventory_file> --list --yaml` - Show the inventory. Useful for debugging dynamic inventory scripts.
