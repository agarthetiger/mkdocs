# Playbooks

## Conditional checks

Conditional checks use the `when:` syntax. When conditions can use raw Jinja2 expressions but can execute regular python code so can access methods like String.find() to check for a text match in a String. Multiple conditions should be enclosed with parenthesis, multiple conditions can be specified in a list where they are all required to be true (logical AND).

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

## Required variables

Often at the beginning of a Playbook or Role you may want to assert that all mandatory variables have been defined. This can avoid more difficult problems further into a playbook, like only finding this out mid-way through a production deployment. 

vars.yml
```yaml
REQUIRED_VARS:
  - application_version # Exists
  - i_dont_exist
```

```yaml
- name: Ensure required variables have been set
  assert:
    that: lookup('vars', item) is defined
  loop: "{{ REQUIRED_VARS }}"
  delegate_to: localhost
  run_once: Yes
```

By using a list of varaible names in vars.yml for example in an Ansible Role, it keeps all the variable declarations together. Note that you cannot use `is defined` directly on `{{ item }}`, you will get the following output (v2.10.4).

```bash
ok: [localhost] => (item=i_dont_exist) => {
    "ansible_loop_var": "item",
    "i_dont_exist": "VARIABLE IS NOT DEFINED!",
    "item": "i_dont_exist"
}
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

You can print a message with variable information in it, combine this with the verbosity level, below which the debug will not output anything. 

```yaml
- debug:
    msg: "System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}"
    verbosity: 4
  when: ansible_default_ipv4.gateway is defined
```

See documentation for the [debug module](http://docs.ansible.com/ansible/latest/modules/debug_module.html).

## Play options

Disable facts gathering

```yaml
- hosts: all
  gather_facts: false
```

## Import and Include
Ansible documentation on [Creating reusable playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html)
Note there are trade-offs when selecting between static and dynamic, any import\* tasks will be static, any include\* tasks will be dynamic. 

* All `import*` statements are pre-processed at the time playbooks are parsed.
* All `include*` statements are processed as they encountered during the execution of the playbook.
