#!/bin/bash

# keyboard short cuts that allow the user to back out
trap '' INT TSTP

GIT_DIR=$(git rev-parse --show-toplevel)

# check if working directory is part of a git repository
[ $? -ne 0 ] && exit 1

# check if the user shot them selves
 
[ $[ $RANDOM % 6 ] == 0 ]  || echo *Click* && exit 

# reset git areas, remove untracked files, clear stash
git reset --hard > /dev/null 2>&1
git clean -dfx > /dev/null 2>&1
git stash clear > /dev/null 2>&1

# get a random directory or file from all git tracked files
# and mark it as sentenced for dead.
IFS=$'\n'
ALL_FILES=( $(git ls-tree -r HEAD --full-name --name-only) )
SENTENCED_FILE=${ALL_FILES[$(( RANDOM * RANDOM % ${#ALL_FILES[*]} ))]}

# remove the random directory/file from the history
git filter-branch --prune-empty --index-filter "git rm -rf --cached --ignore-unmatch ${SENTENCED_FILE}" -f --tag-name-filter cat -- --all > /dev/null 2>&1

echo "Unfortunately, ${SENTENCED_FILE} took a bullet and died."

# garbage collect all git files
git prune > /dev/null 2>&1
git gc --force --aggressive --prune=all > /dev/null 2>&1

# push changes to origin remote
git push --force > /dev/null 2>&1

# "say goodbye" ~ rick astley
echo "*BOOM*"
