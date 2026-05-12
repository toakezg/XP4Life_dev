---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-mcp-setup-20260510-152735
timestamp: 2026-05-10T15:27:35+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: "MCP Setup"
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
# Event vaultforge-code-mcp-setup-20260510-152735

## Summary

- Timestamp: 2026-05-10T15:27:35+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: MCP Setup
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

- source_file: F:\servers\mcp\README.md
- text: # MCP Setup
`F:\servers\mcp` is a local-first MCP bridge workspace.
Its purpose is to make small, inspectable MCP servers that can later connect to ChatGPT Apps or other MCP-compatible clients. The first working server is intentionally narrow:
- local only by default
- no write tools
- no tunnel startup tool
- no widget UI
- only read-only `status`, `list_sources`, `search`, and `fetch`
## Key Docs
- `CODEX_START.md` boots new Codex threads.
- `SYSTEM.md` defines the operating model.
- `PLAN.md` tracks direction and watchpoints.
- `TASKS.md` holds actionable work.
- `CHANGELOG.md` records notable changes.
- `docs\reference\` holds practical setup, tool, security, and testing notes.
- `docs\dcs\` holds DCS packets and handoffs.
## First Server
The first local server lives at:
```text
servers\active\mcp-setup-server
```
Expected local endpoint:
```text
http://localhost:8787/mcp
```
Run...
