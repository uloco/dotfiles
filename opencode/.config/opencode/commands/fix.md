---
description: Fetch a ticket, create a worktree, and start working on it
---

You received a ticket URL as input: `$ARGUMENTS`

Follow this workflow exactly.

## 1. Fetch the ticket

Use every tool you have (Jira MCP, GitLab MCP, web fetch, etc.) to get the
ticket details: title, type (bug, story, task, etc.), description, and
acceptance criteria.

If the URL is not reachable or the ticket cannot be fetched, stop and tell the
user.

## 2. Determine the branch prefix

| Ticket type        | Prefix |
| ------------------ | ------ |
| Bug, Task, Subtask | `fix`  |
| Story, Feature     | `feat` |
| Everything else    | `fix`  |

## 3. Build the branch name

Format: `<prefix>/<TICKET-KEY>-<title-slug>`

- `TICKET-KEY` is the issue key exactly as it appears (e.g. `IOT-123`).
- `title-slug`: lowercase the title, replace spaces and special characters
  with `-`, collapse consecutive hyphens, trim to ~50 characters, drop a
  trailing hyphen.

Example: `fix/IOT-123-broken-sensor-readings-on-dashboard`

## 4. Find the base branch

```sh
git branch -a --list '*/develop' | head -1
```

If a `develop` branch exists, use it. Otherwise use `main`.

Fetch the latest state of the base branch before creating the worktree:

```sh
git fetch origin <base-branch>
```

## 5. Create the worktree

```sh
git worktree add .worktrees/<branch-name> -b <branch-name> origin/<base-branch>
```

If `.worktrees` is not in `.gitignore`, add it.

After creation, confirm the worktree exists:

```sh
git worktree list
```

## 6. Install dependencies

The worktree is a fresh checkout — `node_modules` (or equivalent) does not
exist yet. Detect the package manager from the lockfile in the worktree root
and install, running the command inside the worktree directory:

| Lockfile             | Command       |
| --------------------- | ------------- |
| `yarn.lock`            | `yarn`        |
| `package-lock.json`    | `npm install` |
| `pnpm-lock.yaml`       | `pnpm install`|
| `bun.lockb` / `bun.lock` | `bun install` |

If none of these lockfiles exist, skip this step entirely.

## 7. Tell the user

Print the worktree path and the branch name. Tell the user to `cd` into it
(or switch to it in their editor) and that you are about to start working on
the ticket.

## 8. Start working

Read the ticket description and acceptance criteria carefully.

If anything is unclear or ambiguous, ask the user before writing code. Collect
all questions into one message.

When everything is clear, implement the fix or feature. Aim for the minimal
diff that satisfies the ticket. Do not refactor unrelated code.
