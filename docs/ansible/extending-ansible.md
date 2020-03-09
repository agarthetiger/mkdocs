# Extending Ansible

Before extending Ansible there are several resources which you should be familiar with before diving into the code. 

## Developer Guides

There are lots of documents under the [Developer Guide](https://docs.ansible.com/ansible/latest/dev_guide/index.html) on the Ansible website. Here are some for my quick reference, do read them all though.

* https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html
* https://docs.ansible.com/ansible/latest/dev_guide/developing_plugins.html
* https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html
* https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html
* https://docs.ansible.com/ansible/latest/dev_guide/developing_module_utilities.html
* https://docs.ansible.com/ansible/latest/dev_guide/debugging.html

## Best practice

* https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_best_practices.html
* https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_documenting.html#documentation-block

## Notes

* Don't trust the code in the Ansible repo as gospel. There are old modules which pre-date the current best-practice guidance.
* The `DOCUMENTATION` docstring is meta-information about the plugin you are writing. Changing the documented value of whether an option is required will actually enforce that when executing the plugin. 
* The `DOCUMENTATION` docstring is also what determines the help text for the plugin when running `ansible-doc`.
* Not all examples will follow all the best practices. It will save you time and frustration in the long run to read the documentation first, and continually refer to it as you build a plugin. 
