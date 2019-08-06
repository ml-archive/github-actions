#!/bin/bash

apt-get update && apt-get install -y clang libblocksruntime0 libcurl4-openssl-dev 
apt-get install -y ruby-full make gcc libsqlite3-dev
gem install jazzy --no-ri --no-rdoc

cd $HOME

git clone https://github.com/jpsim/SourceKitten.git ./SourceKitten

cd SourceKitten
swift build -c release --static-swift-stdlib
mv .build/x86_64-unknown-linux/release/sourcekitten /usr/local/bin/

cd $HOME

rm -rf SourceKitten

git config --global user.name = "Github Action"
git config --global user.email = "action@github.com"

git clone https://github.com/$GITHUB_REPOSITORY.git ./project

cd project

git checkout -B gh-pages
git pull origin gh-pages
git merge master

swift package update
swift build
sourcekitten doc --spm-module $TARGET > $TARGET.json
jazzy --clean --sourcekitten-sourcefile $TARGET.json --module $TARGET --output .

git status
git add --all
git rm .github/main.workflow
git rm -rf .circleci/
git commit -m "Jazzy docs updated"
git push origin gh-pages
