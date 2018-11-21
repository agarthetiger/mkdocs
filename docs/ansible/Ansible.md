# Ansible

## Single actions

    ansible all -m setup -i 192.168.0.11,
    
* `ansible all` execute ansible against host group 'all'    
* `-m setup` run the setup module to gather information about the hosts
* `-i 192.168.0.11,` inline host list, must be comma-separated list of hosts so add training comma for a single host.

See [Examples](https://docs.ansible.com/ansible/latest/modules/setup_module.html#examples) on the Ansible Setup module documentation.

## Local actions

If you want to run a playbook and always do things locally, use `- hosts: 127.0.0.1` in the playbook. Execute the playbook using `--connection=local`. This instructs ansible to execute the command locally and not to establish an SSH connection, which is useful if local loobpack is disabled eg. due to firewall rules or security groups. 

To run a playbook which uses `- hosts: all` or similar, pass an inventory with just localhost or 127.0.0.1 and connection=local

    ansible-playbook -i 127.0.0.1, --connection=local myplaybook.yaml

Alternatively, within a playbook with tasks to be executed remotely, include a section with 

    - hosts: 127.0.0.1
      connection: local

More alternatives include using the `local_action` module which is a shorthand syntax for  the `delegate_to: 127.0.0.1` option. Combine these with `run_once: true` to ensure things running locally only happen once if that's what you want (like downloading a file once to then use Ansible to push the file to multiple hosts). 

See Ansible documentation on [Delegation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_delegation.html#delegation) This is useful to switch to running selected tasks locally in the middle of a role execution for example, where you cannot add hosts: directives to switch between local and remote execution.

    - hosts: all
      gather_facts: false
      tasks:
      - name: ensure required parameters have been set
        fail: msg="Variable '{{ item }}' is not defined"
        when: item not in vars
        with_items:
          - public_key_file
          - host_user_id
        run_once: true
      - name: locate public key file
        local_action:
          module: stat
          path: "{{ public_key_file }}"
        register: keyFile
        run_once: true

## Localhost and non-SSH connections
`ansible_connection=local` can be used in the inventory or on the command line to specify how Ansible will connect to the target host. In the case of local actions you can use ansible_connection=local as an inventory parameter with localhost to execute something locally even if you don't have a local loopback connection. The equivalent in a playbook is `connection: local`.

Note localhost will be recognised by Ansible as a valid host if the /etc/hosts file has an entry for 127.0.0.1 localhost or if `localhost 127.0.0.1 ansible_connection=local` is specified in the inventory, otherwise use 127.0.0.1.

## Load variables from a file
On the command line, use -e or --extra-vars. Set additional variables as key=value or YAML/JSON, if filename prepend the filename with @.

    ansible-playbook ... --extra-vars '@my-vars.yaml'

Combine vars from a file and additional vars by using --extra-vars twice.

    ansible-playbook ... --extra-vars '@my-vars.yaml' --extra-vars 'target_env=uat generate_report=true'

See [documentation](https://docs.ansible.com/ansible/2.4/ansible-playbook.html#cmdoption-ansible-playbook-e)

## Roles

Link to Roles documentation
http://docs.ansible.com/ansible/2.4/playbooks_reuse.html

## Magic variables

http://docs.ansible.com/ansible/latest/playbooks_variables.html#magic-variables-and-how-to-access-information-about-other-hosts


## Group and Host Variables

See documentation for [playbooks best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html#group-and-host-variables).

inventory/group_vars/all.yaml
my_var_name: "some value"

Use {{ hostvars[inventory_hostname]['my_var_name'] }} to reference. Note the group_vars/all structure does not mean there is an [all] hosts group to reference, but the vars in all will get applied to all group (hosts), and can be referenced using the magic variable inventory_hostname. Note the use of single quotes for the my_var_name (which is looking up the string 'my_var_name') vs the [inventory_hostname] syntax to index the inventory_hostname in the hostvars array. 

## Ansible Tower
AWX is the upstream open-source version of Ansible Tower. See the [AWX Project](https://www.ansible.com/products/awx-project) for details. You can get it from [GitHub](https://github.com/ansible/awx).

## Ansible tools

### Ansible Run Analysis (ARA)
See the [ARA](https://dzone.com/articles/ansible-run-analysis) article or view the code on [GitHub](https://github.com/openstack/ara).

[Ansible Google Group](https://groups.google.com/forum/#!forum/ansible-project)
[Ansible Source and Releases on GitHub](https://github.com/ansible/ansible/releases)
