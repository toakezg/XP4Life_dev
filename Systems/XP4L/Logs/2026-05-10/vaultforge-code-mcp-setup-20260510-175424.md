---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-mcp-setup-20260510-175424
timestamp: 2026-05-10T17:54:24+00:00
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
# Event vaultforge-code-mcp-setup-20260510-175424

## Summary

- Timestamp: 2026-05-10T17:54:24+00:00
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
- only read-only or dry-run-only `status`, `list_sources`, `search`, `fetch`, `read_project_manifest`, `list_project_manifests`, and `dry_run_create_doc`
Current baseline:
```text
Local root: F:\servers\mcp
Local endpoint: http://127.0.0.1:8787/mcp
Mode: local-read-only
Tools: status, list_sources, search, fetch, read_project_manifest, list_project_manifests, dry_run_create_doc
Current Developer Mode endpoint: https://manufactured-websites-larger-amendments.trycloudflare.com/mcp
```
## Key Docs
- `CODEX_START.md` boots new Codex threads.
- `SYSTEM.md` defines the op...
