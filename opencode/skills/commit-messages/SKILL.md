---
name: commit-messages
description: Write conventional commit messages with reviewer-friendly bodies that explain why the change exists and any important tradeoffs.
compatibility: opencode
---

## What I do

- Provide commit message guidance for git commits.
- Use Conventional Commit style such as `feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`, `test: ...`, and `chore: ...`.
- Encourage logical commit grouping so each commit is easy to review.
- Add a useful commit body when context, decisions, or tradeoffs would help the reviewer.

## When to use me

Use this skill whenever you are about to create one or more commits.

## Required workflow

1. Split the work into logical commits when the changes naturally separate into reviewable steps.
2. Use a Conventional Commit subject line.
   - Examples: `feat: add worker reconnect backoff`, `fix: handle empty position snapshots`, `docs: clarify connector startup flow`.
3. Keep the subject concise and specific.
4. When the reviewer would benefit from more context, include a commit body that explains:
   - why the change is needed
   - any architectural decision that was made
   - important alternatives considered
   - tradeoffs or follow-up implications
5. Prefer commit bodies for reviewer context instead of relying on vague subjects.
6. If the change is straightforward and the subject is fully clear, the body can be omitted.

## Commit style notes

- Good types usually include `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, and `build`.
- Focus on intent and reviewability, not a file-by-file changelog.
- Make each commit message understandable on its own in the history.
- If a commit contains a non-obvious implementation choice, say so in the body.

## Example

```text
fix: preserve subscription state after worker reconnect

The reconnect path rebuilt the worker session without restoring active
subscriptions, which caused clients to stop receiving detail updates.

Restore subscriptions during session rehydration instead of re-requesting
them from the frontend. This keeps the recovery path server-driven and
avoids extra client-side state handling.
```
