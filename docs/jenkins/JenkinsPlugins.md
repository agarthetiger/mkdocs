# Jenkins Plugins

Anyone who has ever administered Jenkins will know that plugins are both essential and problematic. Jenkins can be enhanced through an extensive collection of community maintained plugins, and therein lies the problem. "Want to do 'A' with Jenkins? Yes you can. Want to do 'B' with Jenkins? Yes you can.", goes the sales pitch. However, often A and B are implemented in community plugins which may conflict when installed[^1] or may not work together even if both are installed. 

## [Custom tool plugin](https://wiki.jenkins.io/display/JENKINS/Custom+Tools+Plugin)
Not compatible with Pipelines until [JENKINS-30680](https://issues.jenkins-ci.org/browse/JENKINS-30680) is resolved. This has been open since September 2015.

[^1]: 
    "Installed" must include restarting the Jenkins Master. I've had a plugin cause a conflict when installed, so I uninstalled it. The uninstall didn't resolve the conflict so I restarted to completely remove it. 12 hours later I finally got the Jenkins Master up and running again. I'd been tracking down all the recent changes working backwards to find that a plugin installed 8 months previously (before I joined the company of course) was causing the conflict. I'd overlooked the signs initially, not believing that a change made 8 months ago could have caused the problem. The master had not been restarted in 8 months. If the master had been restarted at the time, the problem would have been detected immediately and the change rolled back right away. Lesson learned, always restart Jenkins after installing or removing plugins and check the logs to ensure the instance comes up cleanly. 

## Pipeline Utility Steps

### [findFiles](https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps/#findfiles-find-files-in-the-workspace)

Returns a [FileWrapper](https://javadoc.jenkins.io/plugin/pipeline-utility-steps/org/jenkinsci/plugins/pipeline/utility/steps/fs/FileWrapper.html) object.

* name - (String) file name and extension
* path - (String) file path including file name and extension. Path does not include the workspace path. 
* directory - (Boolean) True for a directory, otherwise False
* length - (long) Length (size) of the file in bytes
* lastModified - (long) 

