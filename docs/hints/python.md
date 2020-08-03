# pip

* `pip search <package_name>==foobar` - List all available versions for a package. Note ==foobar is a hack and the <package_name> must be an exact match. 

# pypi

* `curl -s "https://pypi.org/pypi/<package_name>/json" | jq  -r '.releases | keys | .[]' | sort -V` - List all versions of a package on pypi.org
