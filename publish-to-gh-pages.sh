#!/bin/bash
set -ev


# get clone master
git clone https://${GH_REF} .deploy_git
cd .deploy_git
git checkout master

cd ../
mv .deploy_git/.git/ ./public/

cd ./public

git config user.name "liuby01"
git config user.email "liuby01@outlook.com"

# add commit timestamp
git add .
git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"

# Github Pages
git push --force --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master

# Coding Pages
git push --force --quiet "https://liuby01:${CODING_TOKEN}@${CD_REF}" master:master
