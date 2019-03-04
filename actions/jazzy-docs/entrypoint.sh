#!/bin/sh -l
apt-get update && apt-get install -y clang libblocksruntime0 libcurl4-openssl-dev
apt-get install -y ruby-full make gcc libsqlite3-dev
gem install jazzy

cd $HOME

git clone https://github.com/jpsim/SourceKitten.git ./SourceKitten

cd SourceKitten
swift build -c release --static-swift-stdlib
mv .build/x86_64-unknown-linux/release/sourcekitten /usr/local/bin/

cd $HOME

rm -rf SourceKitten
git clone $GITHUB_REPOSITORY ./project

cd project

swift package update
swift build
sourcekitten doc --spm-module $TARGET > $TARGET.json
jazzy --clean --sourcekitten-sourcefile $TARGET.json --module $TARGET

git config --global user.name = "$GH_USER"
git config --global user.email = $GH_EMAIL

git checkout -B gh-pages
git status
git add . --force
git commit -m "Jazzy docs updated"
git push origin gh-pages