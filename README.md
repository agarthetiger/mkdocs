## MKDocs MacOS setup

* Optional step to uninstall mkdocs installed via any other means than the steps below. 
* Install python using homebrew. For reference, the build output included this below. Installing python using homebrew is useful rather than installing mkdocs directly via homebrew, as not all of the mkdocs plugins are available via brew and a brew-installed mkdocs will not find pip installed mkdocs plugins. 

    ==> python
    Python has been installed as
      /usr/local/bin/python3

    Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
    `python3`, `python3-config`, `pip3` etc., respectively, have been installed into
      /usr/local/opt/python/libexec/bin

    If you need Homebrew's Python 2.7 run
      brew install python@2

    You can install Python packages with
      pip3 install <package>
    They will install into the site-package directory
      /usr/local/lib/python3.7/site-packages

    See: https://docs.brew.sh/Homebrew-and-Python

* Install mkdocs and mkdocs-material using the brew-installed pip3.

    pip3 install mkdocs mkdocs-material

