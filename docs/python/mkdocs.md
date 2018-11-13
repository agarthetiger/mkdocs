# MKDocs 

This site is built with MKDocs, hosted on GitHub Pages and automatically published on commit to master from Travis CI. 

Good documentation is vital for any enterprise IT team to publish shared practices or software components. To empower other teams and allow them to easily consume the output is key, in order to alleviate the publishing team from becoming yet-another-enterprise-bottleneck. MKDocs and GitHub Pages allows teams to publish documentation without having to worry about site hosting, and the documentation can be easily written in markdown. 

# CI deployments to GitHub Pages with Travis-CI
To publish from master onto the site served from the gh-pages branch I've used Travis CI for this open source site. I based my .travis.yml file on [Derek Weitzel's blog post](https://derekweitzel.com/2017/02/08/deploying-docs-on-github-with-travisci/). As this was my first time using Travis I didn't initally understand what every line was for. A little piece of me dies whenever I see people cutting and pasting from the internet and executing code, or worse just "curl bash piping", especially in an enterprise organisation when they have no idea what code they are running. I've seen that happen way more times than I'd like. Anyway, here is my breakdown of the original script, followed by my enhancements. 

    env:
      global:
      - GIT_NAME: "'Markdown autodeploy'"
      - GIT_EMAIL: djw8605@gmail.com
      - GH_REF: git@github.com:opensciencegrid/security.git
    language: python

Set some environment variables to use later in the job. Setting the language to python tells Travis CI to run this job on a docker container with python and pip pre-installed. 

    before_script:
    - pip install mkdocs
    - pip install MarkdownHighlight

This before_script phase will run prior to the (build) script section running. In the [Job lifecycle](https://docs.travis-ci.com/user/job-lifecycle) Travis CI provides an install phase for installing dependencies which should be used instead. With this script there may be no practical difference between running these steps under the install or before_script phases, however I believe following the patterns intended by the tools is often an easier path to travel in the long term. 

    script:
    - openssl aes-256-cbc -K $encrypted_1d262b48bc9b_key -iv $encrypted_1d262b48bc9b_iv -in deploy-key.enc -out deploy-key -d
    - chmod 600 deploy-key
    - eval `ssh-agent -s`
    - ssh-add deploy-key

MKDocs needs to be able to commit and push to the gh-pages branch in the git repository. The openssl command decrypts the private ssh deploy key, then we limit the permissions and add the key to the running ssh agent. Restricting permissions is required otherwise ssh-add will refuse to add the overly permissive private key file. The eval statement is required to set the apropriate environment variables for the current shell instance so that you can connect to it with ssh-add.  

    - git config user.name "Automatic Publish"
    - git config user.email "djw8605@gmail.com"
    - git remote add gh-token "${GH_REF}";
    - git fetch gh-token && git fetch gh-token gh-pages:gh-pages;

These steps are required in order for mkdocs to push to the GitHub gh-pages branch. In order to understand why, we need to look at the build log which shows Travis CI running something like the following

    $ git clone --depth=50 --branch=master https://github.com/agarthetiger/mkdocs.git agarthetiger/mkdocs
    Cloning into 'agarthetiger/mkdocs'...
    $ cd agarthetiger/mkdocs
    $ git checkout -qf cffa8d732d907f62a08262db229ee5899e2fc795

There would be two issues with trying to run `mkdocs gh-deploy` without the bulk of code in this script phase. First off, the [--depth option on git clone implies --single-branch](https://git-scm.com/docs/git-clone#git-clone---depthltdepthgt). If you add ` git branch -r` or `git remote show origin` as steps into the script you can see that there is apparently no gh-pages branch in the remote. This behaviour can be changed by specifying git.depth: false in .travis.yml which will cause Travis CI to drop the --depth option and the clone will then fetch all branches. This can also be changed by [telling git to clone all branches](https://stackoverflow.com/questions/17714159/how-do-i-undo-a-single-branch-clone) but there is still one more issue. 

The other issue is that we haven't provided a GitHub token or credentials to authenticate to the https GitHub remote with, so even if we add the branch to the origin we still can't push. The clone operation works as this is a public GitHub repository. Using a deploy key and ssh is preferable because any exposure of the credentials in this case would only compromise one repository via the deploy key, rather than compromising all repositories if using a GitHub token.

Back to the original script, and adding a 2nd remote allows the additional branches to be cloned over ssh and also to be pushed to using the decrypted key added to the ssh agent earlier for authentication. The fetch command can be simplified from the example because the initial `git fetch gh-token` fetches all branches. 

    - if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then echo "Pushing to github"; PYTHONPATH=src/ mkdocs gh-deploy -v --clean --remote-name gh-token; git push gh-token gh-pages; fi;

This line first checks to see whether the build was triggered from a Pull Request. Technically this could be avoided, because what we're doing here is building and deploying the website. We could build the site in the script phase of the .travis.yml file and then have all this ssh, git and deploy code running from the deploy phase. This is because the [deploy phase is always skipped for Pull Requests](https://docs.travis-ci.com/user/deployment/#pull-requests). The [script provider](https://docs.travis-ci.com/user/deployment/script/) for deployments requires the script be defined in an external file, which is executed with bash. I've refactored this in my version, as the script example from the blog post is essentially individual bash commands in a yaml dictionary it was quick to translate into a file. Adding `set -e` to the file also allows the script to fail fast and terminate on the first non-zero exit code from a command. Failing fast on error is possibly but ugly to accomplish in the .travis.yml file, requiring every line to append `|| travis_terminate 1` and even this approach has [problems](https://github.com/travis-ci/travis-ci/issues/1066#issuecomment-425757599).

## Travis CI Enhancements

My yaml file looks like this.

    language: python
    branches:
      only:
      - master
    git:
      depth: 1
    install:
    - pip install mkdocs
    - pip install mkdocs-material
    script:
    - if [[ $TRAVIS_PULL_REQUEST == "false" ]]; then mkdocs build --strict; fi;
    deploy: 
      skip_cleanup: true
      provider: script
      script: bash travis-ci/deploy-to-gh-pages.sh
      on:
        branch: master 

I kept the --depth option to still shallow clone the repo with a single branch for the build. Using the branches whitelist I could remove the requirement to check the branch name later in the script, and using a deploy phase meant no additional logic is required to check for pull requests or the branch in the shell script travis-ci/deploy-to-gh-pages.sh. deploy.skip_cleanup stops Travis from stashing changes in the workspace between the (build) script and deploy phases. 
