#### Repository text replacement utility

Clean up vestigial, secret or out-of-date inconsistent information

**_This isn't for daily use as rewriting git history is generally bad
practice for public or shared repositories_**

Backup your repository prior to executing this command.

**_This will invalidate references to this repository's history_**

**_This command rewrites the git repository history_**


Replace old text (map key) with new text (map value) by updating te
kvmap.sh

Process to use and test

0. [Optional] add ready files to gitignore 
    ```
    printf "\n.repo-rm-file.ready\n.repo-text-replace.ready\n" > .gitignore
    ```
0. Backup your repo
0. Edit the key values for the hash map `SEARCH_REPLACE_MAP` or `FILE_REMOVE_MAP` in kvmap.sh
0. Test on the backup
0. *** touch .${0}.ready # for example `touch .repo-rm-file.ready` for the file remove option
0. run with real mapping changes with the --exec option
0. finalize changes test deployments, git push and whatever
0. git gc
0. remove the touch safety file(s)
```
rm -f .repo-rm-file.ready .repo-text-replace.ready
```

*When DRY_RUN is 1, try to do no harm, print commands*


Use
---

After backing up your repository, editing the kvmap.sh you can test
with the `--dry-run` flag

```
    repo-text-replace --dry-run
```

After testing you can verify that you are ready by touching the ready
file and running with the `--exec` flag

```
    touch .repo-text-replace.ready
    repo-text-replace --exec
```

After backing up your repository, editing the kvmap.sh you can test
with the `--dry-run` flag

```
    repo-rm-file --dry-run
```

After testing you can verify that you are ready by touching the ready
file and running with the `--exec` flag

```
    touch .repo-rm-file.ready
    repo-rm-file --exec
```


### Online repo suggestions and reference

https://help.github.com/articles/removing-sensitive-data-from-a-repository/


###
Helpful git aliases for searching the repo



```

[alias]
        # srch online refs with text arg : git srch arg
        srch = log --pretty=oneline --source --all -S
        # regx online refs with text arg : git regx arg
        regx = log --pretty=oneline --source --all -G
        # srchl full commit log of refs with text arg : git srchl arg
        srchl = log --source --all -S
        # regxl full commit log of refs with text arg : git regxl arg
        regxl = log --source --all -G

        # file search =A add =D delete =M modified
        # file globbing may be necessary
        fa = log --pretty="format:" --source --oneline --all --diff-filter=A --
        fd = log --pretty="format:" --source --oneline --all --diff-filter=D --
        fm = log --pretty="format:" --source --oneline --all --diff-filter=M --

        # find files with text arg in them: git find-grep arg
        # similar to emacs command find-grep printing the path to the
        # file with grep output
        find-grep = "!git rev-list --all | xargs git grep " 

        # find file name arg: git find-file filename
        # git find-name '^ *go\.s.*'
        # refs/heads/master:
        #     go.sum
        # git find-name '^ *go\.m.*'
        # refs/heads/master:
        #     go.mod
        # git find-name '^ *go\.'
        # refs/heads/master:
        #     go.mod
        #     go.sum
	    find-file = "!for branch in $(git for-each-ref --format=\"%(refname)\" refs/heads refs/remotes refs/tags); do if git ls-tree -r --name-only $branch | grep \"$1\" > /dev/null; then  echo \"${branch}:\"; git ls-tree -r --name-only $branch | nl -bn -w3 | grep \"$1\"; fi; done; :"
        # alias of find-file
        # similar to emacs command M-x find-name: git find-name filename
        find-name = "!git find-file"

```
