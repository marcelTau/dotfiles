# Git Workflow

1. Use `git` for repository operations.
2. Use `glab` for GitLab operations (for example merge request details, discussions, review comments, and CI/pipeline info).
3. Keep commit messages short and in conventional commit format.
4. Do not add a commit message body unless the change is a large multi-step feature.
5. Prefix branch names with `mt/`.
6. If a feature can be split into steps, create separate commits per step.

## Before Commit Or Push

- Run `cargo clippy`.
- If Rust code was edited, run `cargo fmt`.

## GitLab Merge Requests

Use `glab` for querying GitLab data (merge requests, comments, discussions, etc.).

Use git push options to create a merge request:

```bash
git push -o merge_request.create -o merge_request.title="title" -o merge_request.description="description" -o merge_request.target=master
```
