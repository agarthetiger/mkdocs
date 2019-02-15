# Pipeline DSJ Notes

## Groovy closures 
There has been a [long-standing bug](https://issues.jenkins-ci.org/browse/JENKINS-26481) with using closures like `.each{}` on collections, where the behaviour was incorrect and inconsistent. This [gist](https://gist.github.com/oifland/ab56226d5f0375103141b5fbd7807398) demonstrates some of this behaviour. The bug has now been [fixed](https://github.com/jenkins-infra/jenkins.io/commit/89792a0c8e0a3850f95ec5fe24bbc89f962fb7ed) in plugin:workflow-cps 2.33 although it's worth noting that there may still be other bugs like [this](https://issues.jenkins-ci.org/browse/JENKINS-46749) which at the time of writing are still unresolved.
