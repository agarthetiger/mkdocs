# Ansible Cheat Sheet
## Debugging
`{{ inventory_hostname }}` The inventory name for the current host being iterated over in the task. One of Ansible's [Special Variables][ansible_special_variables].

`{{ ansible_facts }}` Dictionary of facts gathered or cached for the `inventory_hostname`.  

### Print hostvars 
```yaml
- name: print hostvars
  debug: 
    var: hostvars[inventory_hostname]
    # This is the same as {{ ansible_facts }} but note that ansible_facts will work differntly to hostvars[inventory_hostname] when delegating actions to another host.
    verbosity: 2
```

Note that `hostvars[inventory_hostname]` will always give the facts for the specified inventory_hostname, whereas ansible_facts gives it for the machine the task is being run on. This behaviour will be apparent when delegating tasks to other machines, especially localhost which will not have had any facts gathered at all. 

## Flow control
Run a single task in serial in a Role. Note that the [serial keyword][ansible_keywords] is not applicable to a task, so we have to use a workaround with a side-effect which is that the host selected by Ansible to execute the run_once task will report as being changed even when the actual change took place on the host which the task was delegated to. 

```yaml
- name: Enable and start the service
  service:
    name: my_service
    enabled: yes
    state: started
  delegate_to: "{{ item }}"  
  run_once: true
  loop: "{{ ansible_play_batch }}"
```


## Loops
Loops work with `when` and `failed_when` as well as the `until` conditions. `when` will be evaluated once prior to entering the loop, `until` will be evaluated as the loop repetition condition and finally the `failed_when` condition will be evaluated a single time only once the until condition is true or the loop has reached the maximum `retry` limit.

```yaml
  - name: Poll for Cassandra connection
    shell: "echo 'SHOW HOST;' | cqlsh {{ ansible_default_ipv4.address }} -u 'cassandra' --ssl"
    register: result
    until: result.stderr.find("Connection refused") == -1
    retries: 10
    delay: 10 
    changed_when: false
    failed_when: result.stderr.find("Connection refused") != -1
```

## Blocks

Block sections include `block`, `rescue` and `always`. These function like `try`, `catch` and `finally` respectively. Blocks can accept options like run_once and tags, note that they can't be used to apply handlers which must be specified per task.

## Process files on host

The find module can be used to find files on a remote host and then process them in later in the playbook by registering the output. The full filename and path is stored in the registered variable under files.path, which can be looped over as per the example below.

```yaml
- name: find all logstash plugins
  find:
    paths: "{{ logstash_plugins_folder }}"
    patterns: "*.gem"
    recurse: no
  register: plugin_gems
  changed_when: no

- name: ensure all plugins are installed
  logstash_plugin:
    name: "{{ item.path }}"
    state: present
  loop: "{{ plugin_gems.files }}"
  notify: restart logstash
```

## Documentation

* [Special Variables][ansible_special_variables]
* [Keywords][ansible_keywords]
* [Filters][ansible_filters]
* [Jinja2 Filters][jinja2_filters]

[ansible_keywords]: https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html
[ansible_special_variables]: https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html
[ansible_filters]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html
[jinja2_filters]: https://jinja.palletsprojects.com/en/2.10.x/templates/#builtin-filters
