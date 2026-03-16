---
name: linear-tickets
description: Use the Linear MCP to work a ticket through planning, implementation, GitLab delivery, and Linear status updates.
compatibility: opencode
---

## What I do

- Use the Linear MCP for Linear issue reads and updates.
- Explore the codebase before coding, especially files or modules mentioned in the issue.
- Create a git worktree in `/home/marcel/dev/{project-name}-{issue-id}`.
- Make and discuss a plan with the human unless they explicitly said planning discussion is not needed.
- Use TDD for bug fixes and logic changes.
- Group changes into logical commits with reviewer-friendly messages.
- Use the `commit-messages` skill when preparing commits.
- Push the work to GitLab and move the Linear ticket to `In Review` when finished.

## When to use me

Use this when the user asks to pick up, investigate, or complete a Linear ticket end to end.

## Required workflow

1. Use the Linear MCP to fetch the issue details, comments, attachments, linked documents, and project context.
2. Before coding, explore the codebase. If the issue mentions important files, directories, modules, tests, APIs, or docs, inspect those first.
3. Create a git worktree in `/home/marcel/dev/{project-name}-{issue-id}`.
   - Use the project or repository name for `{project-name}`.
   - Use the Linear issue identifier for `{issue-id}`.
   - Sanitize the project name to lowercase kebab-case.
   - Follow existing branch naming conventions if the repo has them.
4. Make a plan and discuss it with the human unless the human explicitly said a plan discussion is not needed.
5. Only start coding after the plan is approved, unless the human explicitly waived that approval step.
6. If the work is a bug fix or logic change, always use TDD.
   - First write or update a test that captures the expected behavior.
   - Run the test and verify it fails against the current code.
   - Only after the failing test is confirmed should you change the implementation.
   - Run the relevant tests again and verify they now pass.
   - If you cannot reproduce the issue with a test, stop and explain that before changing the code.
7. Keep documentation or configuration in sync when the change affects them.
8. Before creating commits, load and follow the `commit-messages` skill.
9. Group changes into logical commits. Each commit message should help a reviewer understand the purpose of the change.
10. If you make architectural decisions, explain the decision, the alternatives considered, and the tradeoffs.
11. Push the changes to GitLab using the `glab` CLI where applicable, and use the repository's normal branch-publish flow when raw git push is still required.
12. Move the Linear ticket to `In Review` when the implementation is done.

## Verification

- Run the relevant tests for the changed area.
- For bug fixes and logic changes, do not skip the failing-test-first step.
- Run any additional lint, build, or formatting steps that the repository expects for the touched code.
