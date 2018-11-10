# Scripted Pipeline Notes

## NonCPS
DSL code can only call methods or use classes which are serializable, unless the non-serializable methods are annotated with @NonCPS. Note there are additional considerations to be aware of. 

* Methods annotated with @NonCPS cannot call any DSL methods, or any other methods unless the other methods are also annotated as NonCPS.
* Methods annotated with @NonCPS which call other methods will have undefined behaviour, including but not limited to returning unexpected values.
* Echo appears to be safe to use to log information from @NonCPS methods. 


