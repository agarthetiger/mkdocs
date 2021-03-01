# Python Packages

A small collection of python packages. Some are notes for further investigation, some I use occasionally and want a reminder for, some I use all the time. This is not a complete list, just a scratchpad of sorts.  

## CLI tools

### Click

https://click.palletsprojects.com/en/7.x/

Definitely my favourite CLI tool so far. Read a comparison of argparse, docopt and click on [Real Python](https://realpython.com/comparing-python-command-line-parsing-libraries-argparse-docopt-click/)

### Nubia

https://github.com/facebookincubator/python-nubia/blob/master/README.md

Nubia is a lightweight framework for building command-line applications with Python. It was originally designed for the "logdevice interactive shell (aka. ldshell)" at Facebook. Since then it was factored out to be a reusable component and several internal Facebook projects now rely on it as a quick and easy way to get an intuitive shell/cli application without too much boilerplate.

Nubia is built on top of python-prompt-toolkit which is a fantastic toolkit for building interactive command-line applications.

### Rich

https://rich.readthedocs.io/en/latest/

Rich is a Python library for writing rich text (with color and style) to the terminal, and for displaying advanced content such as tables, markdown, and syntax highlighted code. I'll use this in the next release of [hint](https://pypi.org/project/hint-cli/).

## Documentation

### Portray

https://github.com/timothycrosley/portray

### MKDocs

https://www.mkdocs.org/

### pdoc3

https://pdoc3.github.io/pdoc/

### terminalizer

https://terminalizer.com/

Ok, so it's Node.js but useful to note here to generate animated terminal gifs for cli documentation. 

## General

### isort

https://github.com/timothycrosley/isort

Sorts your imports, so you don't have to. 

### natsort

https://natsort.readthedocs.io/en/master/

Sort things 'naturally', including but not limited to semantic version numbers.

### parse

https://pypi.org/project/parse/

Simplified regex-based string search.

### python-benedict

https://github.com/fabiocaccamo/python-benedict

dict subclass with keylist/keypath support, I/O shortcuts (base64, csv, json, pickle, plist, query-string, toml, xml, yaml) and many utilities.

### Diagrams as code

https://diagrams.mingrammer.com/

## GUI Tools

### Dear PyGUI

https://github.com/hoffstadt/DearPyGui

## Logging and error handling

### PrettyErrors

https://github.com/onelivesleft/PrettyErrors

"Prettifies Python exception output to make it legible". Tracebacks are legible IMO, the problems are mostly getting users (including myself) to read them carefully and diligently every time. They could still be formatted better for humans though. One to review, my initial impression is I'm not 100% sold on the output. One to compare and constrast with the logging and error handling features in Rich. Could be a useful tool for new users of python though, as it can be configured with no code changes required. 

## Managing

### Poetry

https://python-poetry.org/

Packaging and dependency management. Doesn't yet support autoversioning from Git tags, that's dependent on the plugin framework in v1.2, hopefully soon. Still great for personal projects where manually bumping versions is manageable (ymmv) and releasing to pypi.org is fine to do locally. 

### Sailboat

https://github.com/cole-wilson/sailboat


## Templating

### Cruft

https://timothycrosley.github.io/cruft/

Built in top of cookiecutter, Cruft enables a project template to be reapplied as and when the template is updated.

## Versioning

### setuptools-scm

https://pypi.org/project/setuptools-scm/

setuptools_scm handles managing your Python package versions in SCM metadata instead of declaring them as the version argument or in a SCM managed file. It also handles file finders for the supported SCMs.

### Zest-Releaser

https://github.com/zestsoftware/zest.releaser

Versions using one of four different files, no support for using git tags :(

### bumpversion

https://pypi.org/project/bumpversion/

### Python Semantic Release

https://github.com/relekang/python-semantic-release

## Web

### BeautifulSoup

https://www.crummy.com/software/BeautifulSoup/bs4/doc/

Beautiful Soup is a Python library for pulling data out of HTML and XML files. It works with your favorite parser to provide idiomatic ways of navigating, searching, and modifying the parse tree. Use with Requests.

### Scrapy

https://doc.scrapy.org/en/latest/index.html

Scrapy is a fast (async) high-level web crawling and web scraping framework, used to crawl websites and extract structured data from their pages. It can be used for a wide range of purposes, from data mining to monitoring and automated testing.
