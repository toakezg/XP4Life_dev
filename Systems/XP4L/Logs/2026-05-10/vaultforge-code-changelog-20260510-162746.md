---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-changelog-20260510-162746
timestamp: 2026-05-10T16:27:46+00:00
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
# Event vaultforge-code-changelog-20260510-162746

## Summary

- Timestamp: 2026-05-10T16:27:46+00:00
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
- On 2026-05-11, updated the current public MCP URL to `https://fuzzy-parts-mix.loca.lt/mcp`; connector smoke passed with a 60 second timeout and auth audience was updated to match.
- On 2026-05-11, verified `https://empty-melons-laugh.loca.lt/mcp` as the current passing Developer Mode URL with a 60 second connector smoke timeout.
- On 2026-05-11, chose Auth0 as the OAuth identity provider lane, added fail-closed auth placeholders, `scripts\verify-auth-env.ps1`, and `docs\reference\AUTH_PROVIDER_DECISION.md`; OAuth remains disabled.
- On 2026-05-11, tightened `search` and `fetch` for connector compatibility, added `scripts\run-connector-smoke.ps1`, added `CONNECTOR_RUNS.md` as an approved source, verified local smoke, and recorded that the last successful public smoke URL later returned 408 and needs refresh before ChatGPT use.
- On 2026-05-11, set local `OPE...
