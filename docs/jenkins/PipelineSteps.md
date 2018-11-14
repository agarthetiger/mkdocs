# Pipeline Steps

## [sh](https://jenkins.io/doc/pipeline/steps/workflow-durable-task-step/#sh-shell-script) 
The bash defaults for running sh script is `set -xe` which will print all commands and arguments when executed (-x) and terminate on any non-zero exit code (-e). Note that this behaviour changes if using `returnStatus: true`. In this case the sh step will not terminate on error but the build will still be marked as failed overall, but the build execution will not be halted. It is down to you to check the value returned by the sh step.

# NonCPS
DSL code can only call methods or use classes which are serializable, unless the non-serializable methods are annotated with @NonCPS. Note there are additional considerations to be aware of. 

* Methods annotated with @NonCPS cannot call any DSL methods, or any other methods unless the other methods are also annotated as NonCPS.
* Methods annotated with @NonCPS which call other methods will have undefined behaviour, including but not limited to returning unexpected values.
* Echo appears to be safe to use to log information from @NonCPS methods. 

