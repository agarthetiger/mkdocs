# MKDocs

[![Build Status](https://travis-ci.org/agarthetiger/mkdocs.svg?branch=master)](https://travis-ci.org/agarthetiger/mkdocs)

This repo contains the source for the website https://agarthetiger.github.io/mkdocs/, which is built using MKDocs.

# Usage

As this is now configured to automatically build using Travis-CI from pushes to GitHub, all that is required to update pages is to clone, edit and push changes, or to edit directly via the GitHub GUI. As this is a personal project I accept the risk of occasionally breaking things and do not use branches or PRs for this repo. It is entirely possible to install and run the site locally via the MKDocs python package, see below for instructions for MacOS.

# MKDocs MacOS setup

This is how I personally manage MKDocs on my laptop.

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

* Install virtualenvwrapper by running `pip3 install virtualenvwrapper`. This is one of the very few python packages I install into the system version of python. Everything else can and should be done in a virtual environment. 
* Create a virtual environment to use with mkdocs. `mkvirtualenv mkdocs --python=3.7`
* Install mkdocs and mkdocs-material using the brew-installed pip3.

      pip3 install -r requirements.txt

