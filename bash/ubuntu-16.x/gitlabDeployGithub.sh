#!/usr/bin/env bash

gitlabDeployGithub() {
  destRepoUrl=${1}

  # Remove old repo first,
  # in case of previous fail.
  echo "Remove old repo"
  git remote remove github
  git remote add github "${destRepoUrl}"

  echo "Create temp branch and checkout"
  # Remove branch if exists.
  git branch -d temp
  # Use temp branch to attach head.
  git branch temp
  git checkout temp

  echo "Merge with master"
  git branch -f master temp

  echo "Go to master"
  git checkout master

  # Push on git repo.
  echo "Push"
  git push github master
}
