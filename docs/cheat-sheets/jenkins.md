# Jenkins

As this is my cheat sheet I've used localhost:8080 in the markdown links for the Jenkins master. Replace localhost:8080 with the address of your Jenkins instance.

## Jenkinsfile Pipelines

* http://localhost:8080/pipeline-syntax/ - The Pipeline Syntax Snippet Generator, almost always generates valid Jenkins Pipeline DSL :)
* http://localhost:8080/pipeline-syntax/globals - Global 'variables' docs. In a shared or global library, add a .txt file alongside a .groovy file with text or HTML to automatically have add help to this globals page.
* http://localhost:8080/pipeline-syntax/gdsl - GDSL, auto-complete Jenkins DSL in IntelliJ

## JobDSL 

* http://localhost:8080/plugin/job-dsl/api-viewer/index.html# - JobDSL API documentation, based on the installed plugins on the Jenkins master.

## JCasC

* http://localhost:8080/configuration-as-code/reference - Configration as code reference based on the installed (CasC) plugins and versions. Note not all of the available options are listed here, like the root jobs: option.
* http://localhost:8080/configuration-as-code/schema - JSON schema for the CasC options. Less descriptive and less readable but more complete than the above reference.

## External References

https://javadoc.jenkins-ci.org/ - Java doc for Jenkins API
