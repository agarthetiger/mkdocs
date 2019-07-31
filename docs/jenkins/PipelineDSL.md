# Pipeline DSL Notes

## Groovy closures 
There has been a [long-standing bug](https://issues.jenkins-ci.org/browse/JENKINS-26481) with using closures like `.each{}` on collections, where the behaviour was incorrect and inconsistent. This [gist](https://gist.github.com/oifland/ab56226d5f0375103141b5fbd7807398) demonstrates some of this behaviour. The bug has now been [fixed](https://github.com/jenkins-infra/jenkins.io/commit/89792a0c8e0a3850f95ec5fe24bbc89f962fb7ed) in plugin:workflow-cps 2.33 although it's worth noting that there may still be other bugs like [this](https://issues.jenkins-ci.org/browse/JENKINS-46749) which at the time of writing are still unresolved.

## Script approvals from libraries
If you are a non-admin user writing Jenkins shared libraries, note that non-whitelisted methods will be blocked with an error indicating a script approval is required. Unfortunately library code does not raise a script approval for an admin to approve and the code in question has to be added to a Pipeline job where the methods are called directly from a Pipeline job using "Pipeline script" or "Pipeline Script from SCM". 

To address this, a pattern I have adopted is to include a Groovy Jenkinsfile in the shared library repository called script-approvals.groovy which makes all the method calls requiring approval. It is then easy to create a Jenkins job which executes this pipeline, which can be repeatedly executed by the team responsible for approving scripts until the script runs to completion. This is useful in environments where there are new or multiple Jenkins masters which a library will be used on. 
