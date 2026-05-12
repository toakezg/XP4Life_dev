---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-changelog-20260510-180108
timestamp: 2026-05-10T18:01:08+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: CHANGELOG
xp_awarded: 40
rarity: common
tags:
  - xp4l
  - dot4
  - mcp
  - watcher
  - vaultforge-code
  - mcp-watch
  - watched-change
  - file_summary_logged
  - general
  - log
---
# Event vaultforge-code-changelog-20260510-180108

## Summary

- Timestamp: 2026-05-10T18:01:08+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: CHANGELOG
- XP Awarded: 40
- Rarity: common

## Breakdown

- Base Value: 40
- Complexity Multiplier: 1.0
- Impact Multiplier: 1.0
- Consistency Multiplier: 1.0
- Rarity Multiplier: 1.0
- Streak Length: 1

## Tags

- xp4l
- dot4
- mcp
- watcher
- vaultforge-code
- mcp-watch
- watched-change
- file_summary_logged
- general

## Context

- source_file: F:\servers\mcp\CHANGELOG.md
- text: # CHANGELOG
## 2026-05-10
- On 2026-05-11, implemented scoped write `create_doc` for new markdown drafts only; local and public connector smoke created draft files under `docs/reference/drafts` and kept overwrite/path/shell/network/credential actions blocked.
- On 2026-05-11, added `CODEX_API_PAID_USAGE=1` as an accepted local paid-usage approval flag in the safe verifier; verifier now reports the Codex flag as the approval source when present.
- On 2026-05-11, softened gate workflow to approval-assumed for read-only, dry-run-only, docs, and smoke-test work, while keeping real write/shell/network/credential tools blocked.
- On 2026-05-11, implemented dry-run-only `dry_run_create_doc`; local and public connector smoke passed and the proposed file was not created.
- On 2026-05-11, implemented read-only `list_project_manifests` as metadata-only discovery for approved manifest IDs; local...
