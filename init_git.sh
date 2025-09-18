#!/usr/bin/env bash

# git config set --global user.name
# git config set --global user.email

git config set --global init.defaultBranch main
git config set --global pull.ff only
git config set --global alias.prev "diff HEAD^"
git config set --global alias.mg mergetool
git config set --global alias.new "switch -c"
git config set --global alias.st status
git config set --global alias.sw switch

if command -v meld > /dev/null; then
    git config set --global alias.gmg "mergetool --tool=meld"
fi
