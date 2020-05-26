# Python Quick Reference

## Regular Expressions

* `+` - match the previous RE one or more times
* `?` - match the previous RE zero or one time only eg `ab?` matches `a` or `ab`
* `*?`, `+?` - non-greedy match. eg For the string `<a>something<b>`, `<.*>` will match `<a>something<b>`, using `<.*?>` this will match `<a>`.
* `\.` - Escape matching a dot, eg `r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'` for a basic ip address expression

## References

* [Python 3 re documentation](https://docs.python.org/3/library/re.html)
