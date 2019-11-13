

# gitRepositoryMerger

These scripts are used to merge TWO repository into one by different ways. 
There are 3 scripts within this repository:

	gitMergeRepo_newFolder.sh - This will merge repository B into a folder within repository A.
	gitMergeRepo_newRepo.sh - This will merge repository A and repository B into a new repository C.
	gitMergeRepo_toRepoA.sh - This will merge repository B into a new branch in repository A. Any extra branch will be named svn\(branchName)
	

## Usage:

**gitMergeRepo_newFolder.sh**

	gitMergeRepo_newFolder.sh <newRepoName> <newRepoUrl> <oldRepoAName> <oldRepoAUrl> <newFolderName> <oldRepoBName> <oldRepoBUrl>
	
	Note: Currently creating a new repository is needed
	      Assuming there are no conflict branch name between both repository  (except master)
	
**gitMergeRepo_newRepo.sh**

	gitMergeRepo_newRepo.sh <newRepoName> <newRepoUrl> <oldRepoAName> <oldRepoAUrl> <newBranchName> <oldRepoBName> <oldRepoBUrl>
	
	Note:Assuming there are no conflict branch name between both repository (except master)

**gitMergeRepo_toRepoA.sh**

	gitMergeRepo_toRepoA.sh <oldRepoAName> <newBranchName> <oldRepoBName> <oldRepoBUrl> <newRepoUrl>
	
	Note:Assuming there are no conflict branch name between both repository  (except master)
