#!/bin/sh -l

git config --global user.name = "$GH_USER"
git config --global user.email = $GH_EMAIL

git checkout -B gh-pages
git status
git add . --force
git commit -m "Jazzy docs updated"
git push origin gh-pages

ls -lisa