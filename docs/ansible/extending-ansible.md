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
* Adding `no_log=True` to a sensitive param on a custom module like a password does not present it from being logged if you enable `DEBUG=True` in ansible.cfg. See [protecting-sensitive-data-with-no-log](https://docs.ansible.com/ansible/latest/reference_appendices/logging.html#protecting-sensitive-data-with-no-log)

## Debugging modules in Collections

When writing new Ansible modules it can be difficult to determine where problems occur. Judicious use of display.debug helps, but there can still be times where you just don't know where or why something has gone wrong. Ansible will not display tracebacks even with `DEBUG=True` in ansible.cfg, so sometimes this is the only expedient way to discover where something unexpected has happened.

```python
  try:
    # module code here
  except Exception as e:
      display.debug(msg=traceback.format_exc())
      raise e
```
