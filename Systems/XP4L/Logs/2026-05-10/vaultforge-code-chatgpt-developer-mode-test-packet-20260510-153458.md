---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-chatgpt-developer-mode-test-packet-20260510-153458
timestamp: 2026-05-10T15:34:58+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: "ChatGPT Developer Mode Test Packet"
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
# Event vaultforge-code-chatgpt-developer-mode-test-packet-20260510-153458

## Summary

- Timestamp: 2026-05-10T15:34:58+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: ChatGPT Developer Mode Test Packet
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

- source_file: F:\servers\mcp\docs\reference\CHATGPT_DEVELOPER_MODE_TEST_PACKET.md
- text: # ChatGPT Developer Mode Test Packet
Date: 2026-05-11
Purpose:
Run the approved `MCP-GATE-003` ChatGPT Developer Mode test against the current MCP server without expanding the tool surface.
Gate state:
- `MCP-GATE-001`: `1`, so read-only `search` and `fetch` are available only for approved docs.
- `MCP-GATE-002`: `1`, so one temporary HTTPS tunnel is allowed.
- `MCP-GATE-003`: `1`, so one Developer Mode connection test is allowed after the tunnel is healthy.
- `MCP-GATE-004`: 1 , scoped only to a future exact named write tool; no write tools are available.
- `MCP-GATE-008`:1 ,if no secret or paid API call is required for this test.
Required preflight:
```powershell
Invoke-RestMethod -Uri 'http://127.0.0.1:8787/' -TimeoutSec 10
```
Expected:
```text
name: mcp-setup-server
mode: local-read-only
tools: status, list_sources, search, fetch
```
Tunnel preflight:
```powershell
curl.exe -sS -...
