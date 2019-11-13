#!/bin/bash

newRepoName=$1
newRepoUrl=$2
oldRepoAName=$3
oldRepoAUrl=$4
newBranchName=$5
oldRepoBName=$6
oldRepoBUrl=$7

mkdir $newRepoName
cd $newRepoName

#New git repo with a commit to start
git init
echo temp > tempfile.txt
git add .
git commit -m "Initial commit"

#add remote to repo a and merge
git remote add -f "$oldRepoAName" "$oldRepoAUrl"
git merge "$oldRepoAName/master" --allow-unrelated-histories -m "Merging $oldRepoAName to master"

#delete temp file
git rm tempfile.txt
git commit -m "Clean up initial temp file"

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
		git merge "$branch" --allow-unrelated-histories -m "Merging $branch to branch"
	done
fi

# upload to git
git remote add origin "$newRepoUrl"
git push -u origin --all