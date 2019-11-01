# IUS

IUS is a project started by Rackspace to provide "Inline with Upstream Stable" package for RedHat/CentOS. Tools such as git are often outdated when installing via the standard RedHat base and epel repositories. IUS have a decent [about](https://ius.io/about) page describing why the IUS project exists, read the link if you're interested.

## Consuming packages from IUS

While there are [setup](https://ius.io/setup) and [usage](https://ius.io/usage) pages on the IUS website, there are still a couple of things to note when trying to find or install a package which are not well documented. 

### Package names

As per the [safe replacement packages](https://ius.io/usage#safe-replacement-packages) notes, IUS packages "Uses a different name than the stock package to prevent unintended upgrades". This means that with the ius release repo enabled you may need to search for a wildcard name, like `yum list git*`, in order to find the package name to install. The IUS package will not be called just `git` as this would clash with the stock package name from yum. 

There is a package [search](https://github.com/search?q=org%3Aiusrepo+topic%3Arpm&s=updated) link on the IUS site. This navigates to GitHub where you can see some of the packages available. Searching here for `git` yielded the repo [iusrepo/git222](https://github.com/iusrepo/git222). With the ius-release repo enabled, searching for packages matching `git*` also showed git2u which installs git v2.16.5-1. 
