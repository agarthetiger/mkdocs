# SELinux

Ansible can run with selinux, your experience will vary depending on the details of exactly what you are doing and how. 

## delegate_to: localhost

Tasks which use `delegate_to: localhost` will run on the Ansible control node. This node can have selinux enabled and enforcing. 

## Ansible in a virtual environment

If you have installed and are running Ansible from a virtual environment (venv) then when a playbook uses `delegate_to: localhost` it is the same venv python interpreter that will execute the module locally. 

### Python2

If you are using Ansible in a virtual environment (venv) then the venv python interpreter will not have the selinux python packages installed from libselinux-python. There is a python shim in pypi called selinux which should provide the selinux bindings for Ansible running in a python2 venv. 

### Python3

As far as I've found there is no python3 equivalent. Workarounds from the internet include explicitly setting the python_interpreter for localhost in your inventory to the system version of python, or copying in the selinux folders from the system python's site-packages folder. 

### Setting the localhost python interpreter

The localhost interpreter option should work if you are running Ansible with python2 on CentOS/RHEL7 and are not using a dynamic inventory source. You may have to use `ansible-inventory -i <inventory_script_or_plugin> --list --yaml --output inventory/temp_statis_inventory.yml` to create a temporary file on disk with the inventory, in order to inject the localhost setting [3].

## Python, CentOS and RHEL

Both CentOS 7 and RHEL 7 ship with python2 by default and both have a libselinux-python package available which installs selinux python packages in the system version of python, which is python2. Likewise CentOS 8 and RHEL 8 have a libselinux-python3 package which installs the python selinux support for python3. Although there are python36 packages available for CentOS 7 and RHEL 7 there are no plans to provide libselinux-python3 for either CentOS 7 [1] or RHEL 7 [2].

[1]: https://bugs.centos.org/view.php?id=16389
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=1719978#c33
[3]: https://docs.ansible.com/ansible/latest/inventory/implicit_localhost.html
