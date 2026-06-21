---
name: git-commit
description: >
  Create git commits with intelligent commit message generation.
  Auto-generates commit messages based on recent commit style
  or Conventional Commits.
  Use whenever the user asks to commit, stage changes, create a commit,
  or save work to git. Also use when the user says
  "commit this", "save my changes", or similar git workflow requests.
compatibility: Requires git, standard shell tools (grep, awk, sed)
allowed-tools: Bash(git add:*) Bash(git status:*) Bash(git commit:*) Bash(git diff:*) Bash(git log:*) Bash(git branch:*)
model: haiku
metadata:
  source: converted from commands/git/commit.md
---

# Git Commit

> Stage all changes and create a well-formed git commit.

## Workflow

### Step 1: Gather context

First, collect the current state of the repository by running these commands:

```bash
git status
git diff HEAD
git branch --show-current
git log --oneline -10
```

### Step 2: Determine the commit message

Generate the commit message based on the changes (from `git diff HEAD`):

1. **Match recent commit style** — review `git log --oneline -10` and adopt the same format (e.g., if recent commits use `feat: ...`, `fix: ...`, follow that pattern).
2. **Default: Conventional Commits** — if there are no recent commits to reference, or no clear style is discernible, use [Conventional Commits](https://www.conventionalcommits.org/): `type(scope): short description`, where `type` is one of `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`.

### Step 3: Create the commit

- Stage all changes: `git add .`
- Create the commit: `git commit -m "<message>"`

## Important

- Stage and commit in a single tool-call batch when possible.
- Do not perform any unrelated actions beyond the commit workflow.
