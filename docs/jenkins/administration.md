# Jenkins Administration

## Security

### LTS does not mean patched

Be aware that the Jenkins LTS release ships with default plugins which are not removable from the Jenkins instance and can be pinned to a low version, missing security updates. One such example is Jenkins LTS v2.176.2 which bundles the [Ant plugin](https://wiki.jenkins.io/display/JENKINS/Ant+Plugin) at version 1.2, released in 2013. There was a [security advisory](https://jenkins.io/security/advisory/2018-01-22/) on 22nd Jan 2018 which identified an XSS vulnerability in this plugin affecting [versions up to and including 1.7](https://jenkins.io/security/advisory/2018-01-22/#affected-versions). At the time of writing this a year and a half later, the current LTS Jenkins is still bundling a version of this plugin from nearly 5 years prior. Many users will have no need for this plugin to be present, but it is not removable. I have to presume that the level of automated testing for Jenkins/CloudBees to perform even with less frequent LTS releases is prohibitive from patching all plugins even for security fixes. 
