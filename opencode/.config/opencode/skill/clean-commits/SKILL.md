---
name: clean-commits
description: Use when committing changes to this repository, staging files, or splitting a diff into commits. Ensures commits are separated by concern, small and focused, with short imperative title-only messages (max 72 chars) that explain why, not what.
---

# Clean Commits

Split staged/unstaged changes into small, focused commits — one concern per
commit — and write short, title-only messages in the repo's existing style.

## Repo style

Never assume a style. Always inspect the history of the repo you're
currently working in before writing any message:

```sh
git log --oneline -30
```

Derive the conventions from what you see there — mood/tense (imperative vs.
past tense), capitalization, punctuation, typical length, use of prefixes
(e.g. `fix:`, `feat:`) or conventional-commit scopes, and whether verbs like
"Add"/"Fix"/"Update" are preferred. Match that style exactly, don't import
conventions from other repos or from this skill's own examples.

Regardless of the repo's specific style, always keep these constraints:

- **Title only** — no body, no bullet points, no footers, unless the
  existing history clearly and consistently uses them.
- **Max 50 characters** (matching common `git log` subject-line linting).
- **Why over what** where it isn't obvious from the diff.

## Conventional commits

If `git log --oneline -30` shows the repo uses conventional-commit style
(`type(scope): message`, e.g. `fix(auth): ...`, `feat(api): ...`), get the
`type` and `scope` **from the current branch name first**, before inferring
anything from the diff:

```sh
git branch --show-current
```

Branch names typically encode this directly, e.g.:

- `feat/IOT-123` → `type=feat`, `scope=IOT-123`
- `fix/1234` or `fix(1234)` → `type=fix`, `scope=1234`

Parse the leading type (before the first `/` or `(`) and the ticket/scope
identifier that follows. Use that exact `type(scope)` as the prefix for
**every** commit in this session — even across otherwise-separate concerns,
and even if a given change might arguably warrant a different type. The
branch type always wins. Only the description after the colon changes
between commits.

If the branch name doesn't encode a type/scope, fall back to inferring a
single consistent `type(scope)` from the overall nature of the branch's
changes instead.

If the repo doesn't use conventional commits at all, don't introduce it.

## Splitting by concern

If everything changed serves a single concern, one commit is correct — don't
over-split for its own sake. Otherwise:

1. Run `git status` and `git diff` to see everything that changed.
2. Group changed files/hunks by concern (one feature, one fix, one config
   tweak, one unrelated cleanup — each is its own commit).
3. Never mix unrelated changes (e.g. a new MCP server + an unrelated keybind
   fix) into one commit.
4. Use `git add <files>` or `git add -p` to stage only one concern at a time,
   commit, then move to the next.
5. If a single file has multiple unrelated hunks, use `git add -p` to split
   them into separate commits.
6. Tightly-related changes stay in one commit — e.g. a bug fix plus the
   doc/comment update describing that same fix. Only split when the changes
   address genuinely different concerns.
7. Small unrelated fixes noticed along the way (typo, stray import, etc.)
   still get their own micro-commit rather than being folded into a nearby
   commit — keep them separate even if trivial.
8. Order commits so each one is self-contained: every commit must check out
   and run cleanly on its own, with no errors or crashes. If change B depends
   on change A (e.g. a helper used by a caller), commit A before B. Never
   commit code that references something not yet introduced.

## Workflow

1. `git status` / `git diff` to see the full set of changes.
2. `git log --oneline -30` on **this repo** to derive its style conventions,
   including whether a conventional-commit `type(scope)` prefix is used.
3. If conventional commits are used, run `git branch --show-current` and
   parse `type`/`scope` from the branch name; lock that prefix in for every
   commit this session (fall back to inferring it from the diff only if the
   branch name doesn't encode one).
4. Group changes into concerns, ordered so each commit is buildable/runnable
   on its own (dependencies first).
5. For each concern: stage only its files/hunks, then commit with a short
   title-only message matching the derived style (and shared prefix, if any).
6. If the repo has an obvious quick check (typecheck/lint/test), consider
   running it after each commit to confirm it's error-free before moving on.
7. Show the resulting `git log --oneline` for confirmation before considering
   the task done.
