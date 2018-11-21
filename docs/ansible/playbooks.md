# Playbooks
## Conditional checks

Conditional checks use the `when:` syntax. The [Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html) states "...When conditions are raw Jinja2 expressions and don't require double quotes for variable interpolation.", which is not entirely accurate. When conditions can use raw Jinja2 expressions but can execute regular python code so can access methods like String.find() to check for a text match in a String. Multiple conditions should be enclosed with parenthesis, multiple conditions can be specified in a list where they are all required to be true (logical AND).

### Conditional check examples

```yaml
    when: 
      - tomcat_status_result.stdout.find("JVM is running.") > -1
      - tomcat_status_result.stderr != ""
      - tomcat_status_result.rc == 0

    ---
    - hosts: all
      tasks:
        - name: "print inventory vars"
          debug:
            var: "{{ item }}"
          with_items:
            - inventory_dir
            - inventory_file
          when: inventory_dir | regex_search('dev$')
    
    - hosts: all
      tasks:
        - name: "apply stub role"
          include_role:
            name: issuer-wallet-stub
          when: inventory_dir | regex_search('dev$')
```          

## Filters

See documentation on [filters](http://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html).
Filters use Jinja2, and Ansible ships with some extra ones to those available in Jinja2. Remember that if using a filter in a conditional statement that python methods are also accessible. 

Also note that the online [Jinja2 documentation](http://jinja.pocoo.org/docs/2.10/templates/#builtin-filters) doesn't go back to python-jinja2 2.7 which is what is provided in RedHat repos for RHEL7. There are no RHEL plans to update Jinja2 to anything later, so what you read on the Jinja website will include features not available to Ansible on RHEL7, because of the Jinja2 version. 

To select an item from a list, based on an attribute, use the selectattr with the match filter, as the equalsto filter is only available in Jinja2 2.8.

Given a yaml file like this,

```yaml
    projects:
      - name: project-a
        version: '2.3.4-SNAPSHOT'
      - name: project-b
        version: '1.2.3-SNAPSHOT'
      - name: project-c
      	value: '5.6.7-SNAPSHOT'
```

Select the version of project-b using the following expression.

```yaml
    - hosts: project-hosts-b
      vars:
        - deployable_version: "{{ projects | selectattr('name', 'match', '^project-b$') | map(attribute='version') | list | first }}"
```

References

* [jinja2-selectattr-filter](http://www.oznetnerd.com/jinja2-selectattr-filter/)

## Debug
Use this to debug what is available in hostvars quickly. gather_facts: false would not be a useful option on first execution of this.

    - hosts: ondemand
      gather_facts: false
      tasks:
      - name: "test hostvars for target_environment"
        debug:
          var: hostvars

You can print a message with variable information in it.

    - debug:
        msg: "System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}"
      when: ansible_default_ipv4.gateway is defined

You can dump the contents of a list or map, and set a verbosity level, below which the debug will not output anything. 

    - name: Display all variables/facts known for a host
      debug:
        var: hostvars[inventory_hostname]
        verbosity: 4

See documentation for the [debug module](http://docs.ansible.com/ansible/latest/modules/debug_module.html).

## Play options

Disable facts gathering

    - hosts: all
      gather_facts: false

## Import and Include
Ansible documentation on [Creating reusable playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html)
Note there are trade-offs when selecting between static and dynamic, any import\* tasks will be static, any include\* tasks will be dynamic. 

* All `import*` statements are pre-processed at the time playbooks are parsed.
* All `include*` statements are processed as they encountered during the execution of the playbook.

