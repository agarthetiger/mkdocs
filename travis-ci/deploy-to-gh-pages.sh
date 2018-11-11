!#/usr/bin/env bash
set -xe

openssl aes-256-cbc -K $encrypted_41526d4b983e_key -iv $encrypted_41526d4b983e_iv -in github_deploy_mkdocs_id_ed25519.enc -out ./github_deploy_mkdocs_id_ed25519 -d
chmod 600 github_deploy_mkdocs_id_ed25519
eval `ssh-agent -s`
ssh-add github_deploy_mkdocs_id_ed25519

git config user.name "Travis CI"
git config user.email "agarthetiger@users.noreply.github.com"
git remote add gh-repo "git@github.com:agarthetiger/mkdocs.git"
git fetch gh-repo

if [[ $TRAVIS_PULL_REQUEST == "false" ]]; then 
    echo "Publishing to GitHub Pages site on gh-pages branch."; 
    mkdocs gh-deploy --remote-name gh-repo; 
fi;
