---
name: pr
description: Prepare a pull request in the user's voice and publish only after explicit approval. Apply the same rules to GitLab merge requests.
---

## Prepare

- Follow my writing style and the applicable repository instructions already in context.
- Inspect the working tree, remotes, upstream tracking, all included commits, and the full diff from the base branch.
- Confirm the source and target. Ask if unclear. Check for an existing PR before proposing creation or an edit.
- Describe committed changes only. Do not stage, commit, or rewrite history.
- Default to ready for review. Create a draft only on explicit request, such as `/pr draft`.
- Preserve an existing PR's state unless I request and approve a change.
- Write a short title and one to three concise sentences or bullets. Lead with the problem or result.
- Skip filler, repeated summaries, routine checklists, and unnecessary headings. Keep required template fields brief.
- Include only verified claims and useful test results.

## Preview

- Start with `# Pull request`. Use `# Draft pull request` only for the platform's draft state.
- Put the actual source and target on a separate line as inline code: `<source>` -> `<target>`.
- Qualify repositories only when needed.
- Use `## Title` and `## Description`, each followed by the exact text in a fenced `markdown` block.
- Let the theme color the Markdown. Keep preview headings and fences out of the published text.
- Keep hashes, metadata, and routine checks internal. Omit remote-action lists and verification notes.
- Ask one short question if a blocker requires a decision.

## Approval and publication

- Never write to any remote repository through any tool without explicit approval after the preview.
- Ask to create or update the PR with this exact text. Mention a draft state and any required push in that question.
- Stop and wait. Invocation, initial arguments, earlier approval, and approval of wording alone do not authorize publication.
- Approval covers only the shown text, destination, PR state, branch version, and named actions. Other remote writes require separate approval.
- Recheck the branch version and destination internally before publication. Request fresh approval after any change or revision.
- Use `gh` for GitHub and the available tools for other platforms. Publish the exact approved text and state.
- Use explicit repository and branch arguments. Never force-push or add unapproved metadata.
- After a failed or uncertain write, inspect read-only state and ask before retrying.
- Return the PR URL after success.
