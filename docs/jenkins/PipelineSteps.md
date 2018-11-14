# Pipeline Steps
## [sh](https://jenkins.io/doc/pipeline/steps/workflow-durable-task-step/#sh-shell-script) 
The bash defaults for running sh script is `set -xe` which will print all commands and arguments when executed (-x) and terminate on any non-zero exit code (-e). Note that this behaviour changes if using `returnStatus: true`. In this case the sh step will not terminate on error but the build will still be marked as failed overall, but the build execution will not be halted. It is down to you to check the value returned by the sh step.

### Quotes and sh
Quotes in Jenkinsfiles are not always as simple to get right as you may think. Jenkinsfiles are groovy DSL, which often reference environment variables such as the values for parameterised jobs. Environment variables and groovy vars may both need to be passed to an echo step or to a sh step, sometimes to be evaluated in the Jenkins context, sometimes by the sh. An apparently simple task using process substitution to create a virtual .netrc file or creating a temporary json file (without using [writeJSON](https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps/#writejson-write-json-to-a-file-in-the-workspace)) is often not quite so straightforward unless you remember the rules for quotations for each context.

<script src="https://gist.github.com/agarthetiger/c25afa0a13dcc97c3d2d5362590567a5.js"></script>

### Debugging sh scripts
Add 'cat -n \$0' into sh scripts to get Jenkins to echo out the shell script and line numbers into the console log, to check what Jenkins is actually executing on the agent.
From [this blog](https://devblog.metabrite.com/posts/jenkins-04-sh-step/)

## [NonCPS annotation](https://github.com/jenkinsci/workflow-cps-plugin/blob/master/README.md#technical-design)
DSL code can only call methods or use classes which are serializable, unless the non-serializable methods are annotated with @NonCPS. Note there are additional considerations to be aware of. 

* Methods annotated with @NonCPS cannot call any DSL methods, or any other methods unless the other methods are also annotated as NonCPS.
* Methods annotated with @NonCPS which call other methods will have undefined behaviour, including but not limited to returning unexpected values.
* Echo appears to be safe to use to log information from @NonCPS methods. 

