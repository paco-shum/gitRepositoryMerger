#!/bin/bash

newRepoName=$1
newRepoUrl=$2
oldRepoAName=$3
oldRepoAUrl=$4
newFolderName=$5
oldRepoBName=$6
oldRepoBUrl=$7

mkdir $newRepoName
cd $newRepoName

#New git repo with a commit to start
git init
dir > tempfile.txt
git add .
git commit -m "Initial commit"

#move files from branch master
git remote add -f $oldRepoBName $oldRepoBUrl
git merge $oldRepoBName/master --allow-unrelated-histories -m "Merging $oldRepoBName to Master"
mkdir $newFolderName
git rm tempfile.txt
shopt -s extglob
git mv -k !($newFolderName) $newFolderName
git commit -m "moving $oldRepoBName into $newFolderName folder"
git remote add -f $oldRepoAName $oldRepoAUrl
git merge $oldRepoAName/master --allow-unrelated-histories -m "Merging $oldRepoAName to Master"

#check if there're branch with repos (assuming there are no conflict branch name)
branchs=$(git branch -r | egrep -v "(^\*|master)")
if [ ${#branchs} != 0 ] 
then
	for branch in $branchs
	do
		if [[ $branch == *"$oldRepoBName"* ]]
		then
			git checkout --orphan svn/${branch##*/} master
			git rm -r -f "*"
			git commit -m "Clean up branch files from master"
			git merge $branch --allow-unrelated-histories -m "Merging $branch to branch"
			mkdir $newFolderName
			git mv -k !($newFolderName) $newFolderName
			git commit -m "moving $branch into $$newFolderName folder"
		fi
	done
	for branch in $branchs
	do
		if [[ $branch == *"$oldRepoAName"* ]]
		then
			git checkout --orphan svn/${branch##*/} master
			git merge $branch --allow-unrelated-histories -m "Merging branch B to branch"
			git commit -m "merging $branch into repository"
		fi
	done
fi

#upload to git
git remote add origin $newRepoUrl
git push -u origin --all