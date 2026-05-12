---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-changelog-20260510-153017
timestamp: 2026-05-10T15:30:17+00:00
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
# Event vaultforge-code-changelog-20260510-153017

## Summary

- Timestamp: 2026-05-10T15:30:17+00:00
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
- On 2026-05-11, tightened `search` and `fetch` for connector compatibility, added `scripts\run-connector-smoke.ps1`, added `CONNECTOR_RUNS.md` as an approved source, and verified local plus public smoke runs at `https://legal-bananas-dance.loca.lt/mcp`.
- On 2026-05-11, set local `OPENAI_API_PAID_USAGE_APPROVED=1`; verifier reports `safe_to_call_paid_api: yes`, with no paid API call run yet.
- On 2026-05-11, confirmed `MCP-GATE-013` was set to `1`; paid API execution still remains blocked until `OPENAI_API_PAID_USAGE_APPROVED=1`.
- On 2026-05-11, checked the local paid flag after docs were updated; verifier still reported `OPENAI_API_PAID_USAGE_APPROVED` blocked and `safe_to_call_paid_api: no`.
- On 2026-05-11, added `MCP-GATE-013` as the separate paid OpenAI API approval gate; default is blocked until both the gate and local paid flag are enabled.
- On 2026...
