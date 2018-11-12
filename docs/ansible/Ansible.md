# Ansible Notes

## Single action

    `ansible all -m setup -i 127.0.0.1, --connection=local`
    
* `ansible all` execute ansible against host group 'all'    
* `-m setup` run the setup module to gather information about the hosts
* `-i 127.0.0.1,` inline host list, must be comma-separated list of hosts so add training comman for a single host
* `--connection=local` instruct ansible to just run locally and not to try and establish an SSH connection. Useful if local loobpack is disabled eg. due to firewall rules or security groups. 

See [Examples](https://docs.ansible.com/ansible/latest/modules/setup_module.html#examples) on the Ansible Setup module documentation.

## Local actions
If you want to run a playbook and always do things locally, use `- hosts: 127.0.0.1` in the playbook. Execute the playbook using `--connection=local`

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

## Conditional checks
Conditional checks use the when: syntax. When conditions are raw Jinja2 expressions and don't require double quotes for variable interpolation.

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
    
    ...


## Filters

See documentation on [filters](http://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html).
Filters are really provided by Jinja2, which is python under the hood. Note that the online [Jinja2 documentation](http://jinja.pocoo.org/docs/2.10/templates/#builtin-filters) doesn't go back to python-jinja2 2.7 which is what is provided in RedHat repos for RHEL7. There are no RHEL plans to update Jinja2 to anything later, so what you read on the Jinja website will include features not available to Ansible on RHEL7, because of the Jinja2 version. 

To select an item from a list, based on an attribute, use the selectattr with the match filter, as the equalsto filter is only available in Jinja2 2.8.

eg. 

Yaml file

    projects:
      - name: data-services
        version: '2.3.4-SNAPSHOT'
      - name: service-manager
        version: '1.2.3-SNAPSHOT'
      - name: issuer-wallet-service
      	value: '5.6.7-SNAPSHOT'

Select the version of service-manager using the following expression.

    - hosts: service-manager
      vars:
        - deployable_version: "{{ projects | selectattr('name', 'match', '^service-manager$') | map(attribute='version') | list | first }}"

References

* [jinja2-selectattr-filter](http://www.oznetnerd.com/jinja2-selectattr-filter/)

## Load variables from a file
On the command line, use -e or --extra-vars. Set additional variables as key=value or YAML/JSON, if filename prepend the filename with @.

    ansible-playbook ... --extra-vars '@my-vars.yaml'

Combine vars from a file and additional vars by using --extra-vars twice.

    ansible-playbook ... --extra-vars '@my-vars.yaml' --extra-vars 'target_env=uat generate_report=true'

See [documentation](https://docs.ansible.com/ansible/2.4/ansible-playbook.html#cmdoption-ansible-playbook-e)

## Import and Include
https://docs.ansible.com/ansible/2.4/playbooks_reuse_includes.html

* All `import*` statements are pre-processed at the time playbooks are parsed.
* All `include*` statements are processed as they encountered during the execution of the playbook.

## Roles

Link to Roles documentation
http://docs.ansible.com/ansible/2.4/playbooks_reuse.html

## Magic variables

http://docs.ansible.com/ansible/latest/playbooks_variables.html#magic-variables-and-how-to-access-information-about-other-hosts


## General useful stuff

Disable facts gathering

    - hosts: all
      gather_facts: false


## Group and Host Variables

See documentation for [playbooks best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html#group-and-host-variables).

inventory/group_vars/all.yaml
my_var_name: "some value"

Use {{ hostvars[inventory_hostname]['my_var_name'] }} to reference. Note the group_vars/all structure does not mean there is an [all] hosts group to reference, but the vars in all will get applied to all group (hosts), and can be referenced using the magic variable inventory_hostname. Note the use of single quotes for the my_var_name (which is looking up the string 'my_var_name') vs the [inventory_hostname] syntax to index the inventory_hostname in the hostvars array. 

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

## Ansible Tower
AWX is the upstream open-source version of Ansible Tower. See the [AWX Project](https://www.ansible.com/products/awx-project) for details. You can get it from [GitHub](https://github.com/ansible/awx).

## Ansible tools

### Ansible Run Analysis (ARA)
See the [ARA](https://dzone.com/articles/ansible-run-analysis) article or view the code on [GitHub](https://github.com/openstack/ara).

[Ansible Google Group](https://groups.google.com/forum/#!forum/ansible-project)
[Ansible Source and Releases on GitHub](https://github.com/ansible/ansible/releases)
