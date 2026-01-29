---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git remote:*), Bash(git config:*)
description: Create a git commit
argument-hint: "[-s] [-p] [-m=<message>]"
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

**Arguments:** $ARGUMENTS

## Argument Parsing

Parse the provided arguments:

- **-s** (optional): Only commit already staged changes, do not run `git add`
- **-p** (optional): Push to remote repository after successful commit
- **-m=<message>** (optional): Custom commit message

**Examples:**

```
/commit                              # Add all changes and commit
/commit -s                           # Commit only staged changes
/commit -p                           # Add all changes, commit, and push
/commit -s -p                        # Commit only staged changes and push
/commit -sp # or -ps                 # Commit only staged changes and push
/commit -m="feat: add new feature"   # Custom commit message
/commit -s -p -m="fix: resolve bug"  # Combined flags with custom message
```

## Commit Message Determination

Determine commit message in order of priority:

1. **Use `-m=<message>` argument if provided**
2. **Follow Recent commits format**
3. **Follow Conventional Commits specification**

## Your task

Based on the above changes and parsed arguments, create a single git commit.

### Commit Behavior

**If -s flag is present:**

- DO NOT run `git add`
- Commit only the files that are already staged
- If no files are staged, report an error

**If -s flag is NOT present:**

- Stage all changes using `git add`
- Create the commit

### Push Behavior (if -p flag is present)

Only after the commit is created successfully, push the changes to the remote repository.

Handle the following scenarios:

1. **Upstream branch set**: Use `git push`
2. **No upstream branch**: Use `git push -u origin <branch-name>` to set upstream
3. **Network/remote errors**: Report the error clearly
4. **Push rejected**: Inform the user if rebase/merge is needed, do not force push

IMPORTANT: Only execute push if the commit succeeds. If commit fails, do not attempt to push.

You have the capability to call multiple tools in a single response. Stage and create the commit using a single message. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
