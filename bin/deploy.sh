#!/bin/bash

# Modified from https://gohugo.io/hosting-and-deployment/hosting-on-github/

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

for site in 'bensedat.name' 'bensedat.me'
do
  # Build the project.
  hugo --environment $site

  # Go To Public folder
  pushd sites/$site

  # Add CNAME file
  echo $site > CNAME

  # Add changes to git.
  git add -A

  # Commit changes.
  msg="rebuilding site `date`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"

  # Push source and build repos.
  git push origin master

  # Come Back
  popd
done

