#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: git clone-github-https 'user_name/repo_name' or $0 'user_name/repo_name'"
    exit 1
fi

github_url="https://github.com/$1"
echo "Convert to '$github_url' , cloning it."
git clone $github_url
