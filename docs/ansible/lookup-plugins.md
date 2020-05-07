# Lookup Plugins

You can use ansible-doc -t lookup -l to see the list of available plugins. Use ansible-doc -t lookup <plugin name> to see specific documents and examples. Alternatively browse the list on https://docs.ansible.com/ansible/latest/plugins/lookup.html

## Examples

### with_fileglob

Use `with_fileglob` with a file lookup to use the file contents.

```yaml
  - name: ensure CRDs are present
    k8s:
      state: present
      definition: "{{ lookup('file', item) }}"
    with_fileglob:
    - "files/crd-*.yml"
 ```
 
