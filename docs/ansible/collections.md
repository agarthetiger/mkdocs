# Collections

## Documenting Collections

`ansible-docs` displays documentation from docstrings in the python file which implements the Ansible Module or Plugin. https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_documenting.html describes the expected format for the docstrings. 

While the documentation states "...Any parsing errors will be obvious - you can view details by adding -vvv to the command.", my experience differs. 

The guidelines require adding `# -*- coding: utf-8 -*-` which I'm not a fan of as Python3 sets this by default, however if you are open-sourcing a Collection it must still be compatible with Python2. https://realpython.com/python-encodings-guide/#python-3-all-in-on-unicode

### Testing module documentation

See https://docs.ansible.com/ansible/latest/dev_guide/testing_documentation.html#testing-module-documentation

## Modules and Plugins

A Module runs on the remote system, a Plugin runs on the Ansible Control node. See https://docs.ansible.com/ansible/latest/dev_guide/developing_locally.html#modules-and-plugins-what-s-the-difference

