---
name: tighten-comments
description: Use when reviewing or cleaning up code comments, especially the comments added on the current branch / feature / merge request. Trims overly long, redundant, or obvious comments and keeps only short, clear, focused ones where context is genuinely missing.
---

# Tighten Comments

Review the comments **added on this branch / feature / merge request** and
tighten them. Do not touch comments that already existed on the base branch
unless the user asks.

This covers all comment forms: line comments (`//`, `#`), block comments
(`/* */`), and doc comments (JSDoc/TSDoc, Python docstrings, Rustdoc, etc.).
Doc comments get the same scrutiny — a docblock that just restates the
signature is still noise and should be trimmed or removed.

## Scope: only new comments

First check if the working directory is dirty (`git status --porcelain`).

- **Dirty:** scope to the pending uncommitted changes only (`git diff` for
  unstaged, `git diff --cached` for staged, or both).
- **Clean:** find what changed relative to the base branch, and only consider
  comments inside those diffs.

```sh
# Dirty working directory:
git status --porcelain
git diff; git diff --cached

# Clean working directory — determine the base branch (usually main or
# master), then diff against it:
git diff --merge-base main -- '*'          # full diff vs base
git diff --merge-base main -U0 | grep '^+' # only added lines
```

If the base branch is not `main`, ask or infer it (`git symbolic-ref
refs/remotes/origin/HEAD`). Restrict all edits to comments introduced by these
added lines.

## Principles

1. **Prefer no comment.** Good names and clear structure beat comments. If the
   code already says what the comment says, delete the comment.
2. **Comment the *why*, not the *what*.** Don't narrate what the code obviously
   does. Explain intent, tradeoffs, non-obvious constraints, gotchas, or the
   reason behind a surprising choice.
3. **Only where context is missing.** Add or keep a comment only when behavior
   is non-obvious — edge cases, workarounds, external quirks, subtle ordering,
   or business rules that aren't visible from the code.
4. **Short, clear, focused.** One line if possible. No preamble, no filler, no
   restating the function signature.

## What to remove or shorten

- Comments that restate the code (`// increment i` above `i++`).
- Redundant docblocks that just echo parameter names with no added meaning.
- Multi-sentence explanations where one short clause suffices.
- Commented-out code (delete it; git remembers).
- Decorative banners, section dividers, and noise.
- TODO/FIXME left by the author on this branch that are already resolved.

## What to keep (and tighten)

- The reason for a workaround or hack (keep the *why*, trim the prose).
- Links to issues, specs, or upstream bugs.
- Warnings about non-obvious side effects or ordering requirements.
- Units, ranges, or invariants that aren't expressed in types.

## Examples

Before:

```ts
// This function takes a user id and then it fetches the user from the
// database and returns the user object that was found, or null if there
// was no user found with that id.
async function getUser(id: string) { ... }
```

After (delete — the name and signature already say this):

```ts
async function getUser(id: string) { ... }
```

Before:

```ts
// We need to wait 200ms here
await sleep(200)
```

After (keep the *why*, make it focused):

```ts
// Debounce: upstream API rate-limits bursts under 200ms.
await sleep(200)
```

Before (docblock, no added meaning):

```ts
/**
 * Gets the user.
 * @param id The user id.
 * @returns The user.
 */
async function getUser(id: string): Promise<User | null> { ... }
```

After (delete — types and name already convey this):

```ts
async function getUser(id: string): Promise<User | null> { ... }
```

## Workflow

1. Check if the working directory is dirty; if so use the pending diff,
   otherwise identify the base branch and get the added lines.
2. List each new/modified comment and classify: delete, shorten, or keep.
3. Apply edits, touching only comments — leave logic untouched.
4. Summarize what was removed vs. tightened.
