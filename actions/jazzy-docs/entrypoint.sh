#!/bin/sh

[ -z "$INPUT_TARGET" ] && echo "You need to specify the target in your .yml file." && exit 1;
[ -z "$INPUT_COMMIT_MSG" ] && echo "You need to specify the commit_msg in your .yml file." && exit 1;

set -eu;

git config --global user.name = "Github Actions";
git config --global user.email = "actions@github.com";

git checkout master;
git worktree add --track -B gh-pages docs;

swift build && \
sourcekitten doc --spm-module "$INPUT_TARGET" > "$INPUT_TARGET.json" && \
jazzy --clean --sourcekitten-sourcefile "$INPUT_TARGET.json" --module "$INPUT_TARGET" --output tmp; 

cd docs;
ls -A | grep -vw .git | xargs rm -rf;
cp -R ../tmp/* .;

git add .;
git commit -m "$INPUT_COMMIT_MSG";
git push -f "https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git" gh-pages;