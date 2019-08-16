#!/bin/sh

git config --global user.name = "Github Actions"
git config --global user.email = "actions@github.com"

git clone https://github.com/$GITHUB_REPOSITORY.git ./project

cd project

swift build && \
sourcekitten doc --spm-module $TARGET > $TARGET.json && \
jazzy --clean --sourcekitten-sourcefile $TARGET.json --module $TARGET --output ../docs && \
\
git reset --hard HEAD^ && \
git checkout -B gh-pages && \
git pull origin gh-pages && \
\
mv .git ../docs && \
cd ../docs && \
\
git add . && \
\
git commit -m "Update Jazzy docs" && \
git push origin gh-pages
