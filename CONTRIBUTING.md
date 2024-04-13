Thank you for taking an interest in contributing.

When time permits, some preliminary work may be published  
in a topic Git branch for _a candidate_ [JEP](https://openjdk.org/jeps/0) that is going to  
introduce new syntax.  Look for it when it is applicable.

Note that this repository does not share Git history with  
[the official Vim repository](https://github.com/vim/vim).  On the one hand, it houses  
only filetype and syntax files for Java, along with tests  
and documentation, which brings to a focus the well-defined  
set of files that can bear relevance to potential changes.  
On the other hand, integration demands a few more hurdles  
to clear.

Please proceed as follows:

1. Clone (or pull from) this Git repository.

2. Create a new topic branch from the `master` branch.

3. "Rebase" the files in `runtime/` and its descendants:

		# Run the next script to let either "wget" or "curl" to
		# download the files listed in "tools/assets.txt" from
		# the "master" branch of the official Vim repository,
		# remaking their directory hierarchies as declared in
		# the file; in addition, this script will generate
		# a Git-untracked templet file "COMMIT_MSG" in the
		# current directory:
		./tools/rebase.sh

		# Now, if a file, e.g. "runtime/doc/syntax.txt", may
		# have changed elsewhere, but require no further change
		# on your part -- discard the newer revision of that
		# file:
		git restore -- runtime/doc/syntax.txt

		# When the downloaded files (and the restored files, if
		# any) match the checked out files, that is, the working
		# tree is clean ("git status"), go to Step 4.

		# Otherwise, update the index and record the changes in
		# a separate commit, using the contents of the generated
		# templet file while composing the commit message; in
		# the message body, mention the filenames included in
		# this commit and prefix them with the supplied SHA
		# revision value, followed by "/"; finally, expunge any
		# remaining filenames at the bottom of the commit body
		# that have been inserted from the templet:
		git commit -t COMMIT_MSG
		rm COMMIT_MSG

4. Make your changes and commit them to this branch.  Any  
    time the list of Git-tracked files is changed (e.g. when  
    another syntax test file is introduced), and these files  
    are not `tools/` or any of its descendants, always update  
    `tools/assets.txt` accordingly in the same commit.

5. Before the changes are pushed to a remote repository and  
    a pull request is entertained, remember to ensure that  
    the files you have based your changes on are still up to  
    date by starting an interactive rebasing session and  
    using `break` after its top commit and then repeating  
    Step 3, resolving conflicts along the way:

		git rebase --interactive master~1
		./tools/rebase.sh
		rm COMMIT_MSG
		git rebase --continue

