# Vars and Facts

## Vars

### Magic variables

Commonly used magic variables include `hostvars`, `groups`, `group_names`, and `inventory_hostname`. `groups` is a list of all the groups (and hosts) in the inventory.

* `inventory_dir` is the pathname of the directory holding Ansible’s inventory host file
* `inventory_file` is the pathname and the filename pointing to the Ansible’s inventory host file.
* `inventory_hostname` is the name of the target host for the current play. This is the remote target even when the task uses `delegate_to`.
* `inventory_hostname_short` is useful if your host has a long fqdn and you only need the hostname up to the first period. Note this comes from the inventory, not from the target host, useful if `gather_facts` is disabled.
* `ansible_hostname` is a discovered fact from the remote host, so not available with `gather_facts` disabled.

See the [ansible docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#accessing-information-about-other-hosts-with-magic-variables) for more details.

### Group and Host Variables

See documentation for [playbooks best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html#group-and-host-variables).

inventory/group_vars/all.yaml
my_var_name: "some value"

Use `{{ hostvars[inventory_hostname]['my_var_name'] }}` to reference. Note the group_vars/all structure does not mean there is an `[all]` hosts group to reference, but the vars in all will get applied to all group (hosts), and can be referenced using the magic variable inventory_hostname. Note the use of single quotes for the my_var_name (which is looking up the string 'my_var_name') vs the [inventory_hostname] syntax to index the inventory_hostname in the hostvars array. 

### Load variables from a file
On the command line, use -e or --extra-vars. Set additional variables as key=value or YAML/JSON, if filename prepend the filename with @.

    ansible-playbook ... --extra-vars '@my-vars.yaml'

Combine vars from a file and additional vars by using --extra-vars twice.

    ansible-playbook ... --extra-vars '@my-vars.yaml' --extra-vars 'target_env=uat generate_report=true'

See [documentation](https://docs.ansible.com/ansible/2.4/ansible-playbook.html#cmdoption-ansible-playbook-e)

## Facts

### Setup module

Basic example of running the setup module locally.

`ansible -m setup all -i localhost, --connection=local`

### Sample Facts

Quick reference for some of the facts I commonly use.

| Fact | Values (not exhaustive list) | 
|------|--------|
| ansible_os_family | 'RedHat', 'Darwin', Debian' |
| ansible_distribution | 'CentOS', 'MacOSX', 'Ubuntu' |
| ansible_distribution_major_version | '7' |
| ansible_distribution_version | '7.4.1804' |
| ansible_pkg_mgr | 'yum', 'apt', 'homebrew' |
| ansible_system | 'Linux', 'Darwin' |
| ansible_lsb | dict containing id (ansible_distribution), release (ansible_distribution_version) and others. Depends on lsb package being installed. |
| ansible_hostname | |
| ansible_fqdn | |
| ansible_env | |
| ansible_dns.nameservers | List of name server IPs |
| ansible_dns.search | List of domains to search |
| ansible_domain |  | 

Access facts per host by just referencing the fact name as a variable. They are also available via `{{ ansible_facts['fact_name'] }}` or `hostvars[inventory_hostname]['fact_name']`. Note that ansible_facts is a subset of hostvars[inventory_hostname].

```yaml
---
- hosts: localhost
  connection: local
  tasks:
    - name: print ansible_facts
      debug:
        var: ansible_facts

    - name: print all host facts
      debug:
        var: hostvars[inventory_hostname]
```
