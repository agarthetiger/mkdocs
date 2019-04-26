# Bash reference

## Process substitution

This example was used to upload a file to post a file to a site requiriing authentication, without ever writing the credentials to disk or having them exposed in the command history or the running process list while the command is executing. Note that this code was run from a Jenkinsfile pipeline shared library, so the ${} variables are coming from Jenkins (Groovy) DSL.

```bash
response_code=\$(curl -w %{http_code} --netrc-file <(cat <<<'machine $uploadDomain login ${Username} password ${Password}') -sS --upload-file ${filename} '${uploadUrl}')
```

Breaking this command down

`<<<'Something here'` is a [here string](https://www.tldp.org/LDP/abs/html/x17837.html), a variant of a here doc where the (variables in the) string are expanded before being fed to standard input.

`<( command )` is [process substitution](http://tldp.org/LDP/abs/html/process-sub.html) where the standard output of one process can be fed to the standard input of another process. In this case we're using process substitution and cat to feed curl with a netrc 'file' without ever writing the file to disk.
 
`--netrc-file` is a [curl option](https://ec.haxx.se/usingcurl-netrc.html) which can be used to provide credentials for curl to present when connecting to specified domains.

## Comments

The `#` symbol is a bash comment, and can also be used to to stop processing of command line options. This is useful in git alias commands where we want to reference command line args in the git alias. Without the hash at the end of the alias below, using GitBash on Windows 10, the code will error with a message like `grep: develop: No such file or directory`. Adding the comment halts processing and the command works as expected. 

```bash
alias.prune-merged=!git branch --merged "$1" |grep -v -e develop -e master -e "$1" #
```

## Explain Shell
[Explain Shell](https://explainshell.com/) can be useful to start to understand complex bash commands. 

!!! warning
    Remember this is a public (untrusted) website so be very careful about what you paste in here. 

