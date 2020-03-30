![Jengu Logo](../img/Jengu2wide.png)

## A lightweight Jenkins Shared Library test framework

I spent nearly two years working with Jenkins and building CI/CD pipelines for hundreds of repos, on Jenkins instances with thousands of jobs. There were enough common development patterns, tools and process across the projects needing CI and CD to warrant extensive use of Jenkins DSL Shared Libraries, to reduce the repetition in pipeline implementations across projects. 

When developing any library to be consumed out of site of the authors, two things which are paramount are good documentation and comprehensive automated tests. Testing Jenkins Shared Library code is possible, but there are not many examples of how to do this. We were testing lots of Java code and knew Jenkins could consume and display a JUnit test report in XML, plus the applications we were testing had builds running on branches and PRs which we wanted to for the Jenkins libraries also. 

I wrote a lightweight test framework, which is part-way between unit testing and integration testing. I've continued to develop this and it's now open source on GitHub at https://github.com/agarthetiger/jengu
