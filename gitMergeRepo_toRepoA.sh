#!/bin/bash

oldRepoAName=$1
newBranchName=$2
oldRepoBName=$3
oldRepoBUrl=$4
newRepoUrl=$5

cd $oldRepoAName

#add remote to repo b and merge to new branch
git checkout --orphan "$newBranchName" master
git rm -r -f "*"
git commit -m "Clean up branch files from master"
git remote add -f "$oldRepoBName" "$oldRepoBUrl"
git merge "$oldRepoBName/master" --allow-unrelated-histories -m "Merging $oldRepoBName to branch"

#check if there're branch with repos (assuming there are no conflict branch name)
branchs=$(git branch -r | egrep -v "(^\*|master)")
if [ ${#branchs} != 0 ] 
then
	for branch in $branchs
	do
		git checkout --orphan svn/${branch##*/} master
		git rm -r -f *
		git commit -m "Clean up branch files from master"
		printf "git merge "$branch" --allow-unrelated-histories -m \"Merging $branch to branch\""
		git merge "$branch" --allow-unrelated-histories -m "Merging $branch to branch"
		
	done
fi

#upload to git
git remote add origin $newRepoUrl
git push -u origin --all