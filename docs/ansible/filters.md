# Filters

## Use-case - extract text from html
This was developed to perform post-deployment verification against a RESTful service. The tomcat app startup script would always return before the application was ready to serve traffic and also there is a belt-and-braces check against a version endpoint to check that the url is serving the version on the application we believe should have just been deployed. The [uri](https://docs.ansible.com/ansible/latest/modules/uri_module.html) module handles getting what is unfortunately in this case html, then we need to extract the application version from the content. Cue Ansible [Filters](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#regular-expression-filters)

### regex_search
regex_search can perform the search and return the matched string. I won't share the whole html here, but note there are multiple versions in the html with no unique IDs on any of the elements. So how to extract just the application version? Although in python we can get this using a single regex and a match group, regex_search cannot return just the match group, only the whole match.

```html
<li>application version : 7.12.0-SNAPSHOT</li>
```

We can do this in two simple steps using regex_search, the first filter matches the project version and sets that as a fact which we can search again and this time there is only one version number in the string to be searched and extracting the version number is now easy with a second regex.

```yaml
    - name: extract version element from response
      set_fact:
        deployed_application_version_element: "{{ response | regex_search('application version : ([\\w\\.\\-]+)') }}"

    - name: extract version string from element
      set_fact:
        deployed_application_version: "{{ deployed_application_version_element | regex_search('(\\d+.*$)') }}"

    - name: check facts
      debug:
        var: deployed_application_version
```

!!! note
    Ansible (2.6) does not support having both facts set in a single task. The following code prodeces the error below because the first fact is not set when the second fact tries to reference it. 
    ```yaml
        - name: extract versions from response
          set_fact:
            deployed_application_version_element: "{{ response | regex_search('application version : ([\\w\\.\\-]+)') }}"
            deployed_application_version: "{{ deployed_application_version_element | regex_search('(\\d+.*$)') }}"

    ```
    ```bash
    TASK [extract versions from response]  *****************************************************************************************
    fatal: [localhost]: FAILED! => {"msg": "Unexpected templating type error occurred on ({{ deployed_application_version_element | regex_search('(\\\\d+.*$)') }}): expected string or buffer"}
    ```
    The error is clearer if we drop the regex_search filter from the second fact, although as always we must read the Ansible error message carefully and fully.
    ```yaml
        - name: extract versions from response
          set_fact:
            deployed_application_version_element: "{{ response | regex_search('application version : ([\\w\\.\\-]+)') }}"
            deployed_application_version: "{{ deployed_application_version_element }}"

    ```
    ```bash
    TASK [extract versions from response] *****************************************************************************************
    fatal: [localhost]: FAILED! => {"msg": "The task includes an option with an undefined variable. The error was: 'deployed_project_version_match' is undefined\n\nThe error appears to have been in '/Users/agar/code/agarthetiger/ansible/check-version.yml': line 9, column 7, but may\nbe elsewhere in the file depending on the exact syntax problem.\n\nThe offending line appears to be:\n\n\n    - name: extract versions from response\n      ^ here\n"}

### regex_replace
It would be elegant to get this in one step and we can do that with regex_replace, where the replacement string can reference match groups. We need to modify the original regex slightly so the entire string is matched, in order for just the replacement match group to become the returned string. 

Lets break the regex down.

* The leading `^.*` and trailing `.*?$` ensure that the whole string is matched and replaced by the match group
* `application version :` matches the text in the list html element for the version we're interested in 
* `([\w\.\-])` matches any word character (letters, numbers and underscore) plus dot and hyphen and the round brackets around this expression mark it as the first (and only) match group.

```yaml
    - name: extract application version from response
      set_fact:
        deployed_application_version: "{{ response | regex_replace('^.*application version : ([\\w\\.\\-]+).*?$', '\\1') }}"
```

Online tools like [pythex.org](https://pythex.org/) can be useful for quickly testing regular expressions. 

!!! danger
    Be very careful about what you paste into online tools like this. Always triple check that you are never sharing anything sensitive and if in doubt test a rexeg locally, even if it is more cumbersome. Security is never worth risking for speed. 

## Use-case - search for text in json

A RESTful API returned a json payload which we needed to search through for a name stored in a variable. 

This didn't work, the variable `{{ check_control_plane }}` was never interpolated so the name was never found even when it was present. 

```yaml
- name: set fact with controlplane check
  set_fact:
      pingdom_controlplane_check: "{{ pingdom_checks.json.checks | json_query('[?name==`{{ check_controlplane_name }}`]') | list }}"
```

This does work as expected.

```yaml
  - name: set fact with controlplane check
    set_fact:
      pingdom_controlplane_check: "{{ pingdom_checks.json.checks | json_query(query) | list }}"
    vars:
      query: "[?name=='{{ check.controlplane.name }}']"
```
