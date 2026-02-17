---
name: cwrs-logs
description: Use cwrs to inspect AWS CloudWatch logs when asked about aws logs, cloudwatch logs, or cwrs.
---

## What I do

- Use the `cwrs` CLI to fetch AWS CloudWatch logs for one or more log groups.
- Prefer fast, targeted queries to reduce noise and cost.
- Reuse cached query results from local files when possible.

## When to use me

Use this skill when the user asks to:

- Debug something using AWS logs or CloudWatch logs.
- Use `cwrs` directly.
- Investigate service/runtime behavior from log output.

## Required workflow

1. If log-group names are not provided, check local guidance before asking the user:
   - `AGENTS.md`
   - `CLAUDE.md`
2. Look specifically for CloudWatch log-group names or logging conventions.
3. If still unknown, ask the user for the log-group name(s) (comma-separated if multiple).

## Command rules

- Always include `--no-color`.
- Never use `-f` / `--follow`.
- Keep `--lookback` as short as needed for the current debugging step.
- Use multiple log groups with `--log-groups "group-a,group-b"` when needed.

## Caching policy

- Cache each unique query in a local file and reuse it instead of repeating the same `cwrs` command.
- Suggested cache path: `.opencode/cache/cwrs/`.
- Include query parameters in the filename (or nearby metadata) so cache hits are unambiguous.

## cwrs --help

```text
AWS CloudWatch Logs tail tool

Usage: cwrs [OPTIONS] --log-groups <LOG_GROUPS>

Options:
  -l, --log-groups <LOG_GROUPS>  Comma-separated list of log group names
      --color-uuids              Color UUIDs consistently (same UUID = same color)
      --highlight <HIGHLIGHT>    Highlight a word in red
      --lookback <LOOKBACK>      How far back to fetch logs (e.g., "5m", "1h", "30s") [default: 5m]
  -x, --exclude <EXCLUDE>        Exclude lines containing this text (can be specified multiple times)
  -f, --follow                   Follow (tail) the log stream after fetching historical logs
      --no-color                 Disable colored output
  -h, --help                     Print help
```
