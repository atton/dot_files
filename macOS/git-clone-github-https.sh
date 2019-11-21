#!/bin/sh
cd `dirname $0`

if [ $# -ne 1 ]; then
    echo "Usage: $0 'user_name/repo_name' or git clone-github 'user_name/repo_name'"
    exit 1
fi

github_url="https://github.com/$1"
echo "Convert to $github_url, cloning it."
git clone $github_url
