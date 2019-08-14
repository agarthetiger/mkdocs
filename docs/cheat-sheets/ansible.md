# Ansible Cheat Sheet
## Debugging
`{{ inventory_hostname }}` The inventory name for the current host being iterated over in the task. One of Ansible's [Special Variables][ansible_special_variables].

`{{ ansible_facts }}` Dictionary of facts gathered or cached for the `inventory_hostname`.  

### Print hostvars 
```yaml
- name: print hostvars
  debug: 
    var: hostvars[inventory_hostname]
    # This is the same as {{ ansible_facts }}
    verbosity: 2
```

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

Block sections include `block`, `rescue` and `always`. These function like `try`, `catch` and `finally` respectively.

## Documentation

* [Special Variables][ansible_special_variables]
* [Keywords][ansible_keywords]

[ansible_keywords]: https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html
[ansible_special_variables]: https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html
