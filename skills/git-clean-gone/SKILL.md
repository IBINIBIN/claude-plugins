---
name: git-clean-gone
description: >
  Cleans up local git branches that have been deleted on the remote
  (marked as [gone]), including removing associated git worktrees.
  Use when the user wants to clean up stale branches, remove dead
  branches, prune local branches, synchronize with remote, or when
  they mention branches showing "[gone]". Also use for general
  git branch housekeeping and worktree cleanup.
compatibility: Requires git, standard shell tools (grep, sed, awk)
allowed-tools: Bash(git branch:*) Bash(git worktree:*) Bash(git rev-parse:*) Bash(grep:*) Bash(sed:*) Bash(awk:*)
model: haiku
metadata:
  source: converted from commands/git/clean_gone.md
---

# Git Clean Gone

> Remove local branches whose remote tracking branches have been deleted, along with any associated worktrees.

## Workflow

Your task is to find and delete all local branches marked as `[gone]` — branches whose remote counterparts no longer exist. The process has three steps.

### Step 1: Identify [gone] branches

Run this command to list all local branches and their status:

```bash
git branch -v
```

Look for lines containing `[gone]`. A `+` prefix on a branch indicates it has an associated worktree.

If no branches are labeled `[gone]`, there is nothing to clean up. Report this and stop.

### Step 2: List worktrees

To handle branches with worktrees properly, list all worktrees:

```bash
git worktree list
```

### Step 3: Remove worktrees and delete branches

Run this combined script to process all [gone] branches:

```bash
git branch -v | grep '\[gone\]' | sed 's/^[+* ]//' | awk '{print $1}' | while read branch; do
  echo "Processing branch: $branch"
  # Find and remove worktree if it exists
  worktree=$(git worktree list | grep "\\[$branch\\]" | awk '{print $1}')
  if [ ! -z "$worktree" ] && [ "$worktree" != "$(git rev-parse --show-toplevel)" ]; then
    echo "  Removing worktree: $worktree"
    git worktree remove --force "$worktree"
  fi
  # Delete the branch
  echo "  Deleting branch: $branch"
  git branch -D "$branch"
done
```

### How the script works

- `grep '\[gone\]'` — filters to only branches with `[gone]` status
- `sed 's/^[+* ]//'` — strips the `+` (worktree marker), `*` (current branch), or leading space from each line
- `awk '{print $1}'` — extracts the branch name
- For each branch: check if a worktree exists, remove it (unless it's the current repo), then force-delete the branch

## Important

- Never delete the current branch or its worktree.
- If no branches match `[gone]`, report that no cleanup was needed — this is a success, not an error.
- Run all three commands in sequence and report what was removed.
