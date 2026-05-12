---
title: User Routing Property Pass
user: toakezg
created: 2026-05-11
status: complete
tags:
  - xp4l
  - schema
  - user-routing
---
# User Routing Property Pass

## What Changed
Added `user: toakezg` to the main XP4Life point-routing surfaces:
- quest templates and quest notes
- achievement notes
- reward/title notes
- XP4L reward notes
- root progression state

## Boundary
Skipped generated XP4L log files and active `.4` inbox event JSON.

Reason: event intake has been contract-sensitive, so `user` should be added to live event payloads only after the parser/contract accepts it deliberately.

## Verification
- Targeted Markdown files checked: 90
- Targeted Markdown files missing `user`: 0
- `Systems/XP4L/State/progression_state.json` still parses as JSON

## Next Useful Prompt
```text
CodexForge, inspect the XP4L event contract and propose the smallest safe change to accept user on incoming events. Do not rewrite the active .4 inbox until the contract and dry run are updated.
```
