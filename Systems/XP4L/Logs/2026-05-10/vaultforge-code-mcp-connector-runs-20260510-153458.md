---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-mcp-connector-runs-20260510-153458
timestamp: 2026-05-10T15:34:58+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: "MCP Connector Runs"
xp_awarded: 42
rarity: uncommon
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
# Event vaultforge-code-mcp-connector-runs-20260510-153458

## Summary

- Timestamp: 2026-05-10T15:34:58+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: MCP Connector Runs
- XP Awarded: 42
- Rarity: uncommon

## Breakdown

- Base Value: 40
- Complexity Multiplier: 1.0
- Impact Multiplier: 1.0
- Consistency Multiplier: 1.0
- Rarity Multiplier: 1.05
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

- source_file: F:\servers\mcp\docs\reference\CONNECTOR_RUNS.md
- text: # MCP Connector Runs
## Purpose
This note records the current connector-development lane for the local MCP setup server.
Current archetype: `tool-only`.
Reason: the server is a data-first connector surface for ChatGPT Developer Mode, company knowledge style reads, and later fetch-based connector management. Widget UI and write-capable management tools remain separate future gates.
## Current Tool Surface
```text
status
list_sources
search
fetch
```
All current tools are read-only:
```text
readOnlyHint: true
destructiveHint: false
openWorldHint: false
```
## Connector Compatibility Rules
Official docs checked during this pass:
- `https://developers.openai.com/apps-sdk/build/mcp-server#company-knowledge-compatibility`
- `https://platform.openai.com/docs/mcp#search-tool`
- `https://platform.openai.com/docs/mcp#fetch-tool`
- `https://developers.openai.com/api/docs/guides/developer-mode#ho...
