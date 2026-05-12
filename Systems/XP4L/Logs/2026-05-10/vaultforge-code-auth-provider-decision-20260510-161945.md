---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-auth-provider-decision-20260510-161945
timestamp: 2026-05-10T16:19:45+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: "Auth Provider Decision"
xp_awarded: 44
rarity: rare
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
# Event vaultforge-code-auth-provider-decision-20260510-161945

## Summary

- Timestamp: 2026-05-10T16:19:45+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: Auth Provider Decision
- XP Awarded: 44
- Rarity: rare

## Breakdown

- Base Value: 40
- Complexity Multiplier: 1.0
- Impact Multiplier: 1.0
- Consistency Multiplier: 1.0
- Rarity Multiplier: 1.1
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

- source_file: F:\servers\mcp\docs\reference\AUTH_PROVIDER_DECISION.md
- text: # Auth Provider Decision
## Current Decision
Chosen identity provider lane: Auth0.
Reason: Auth0 has MCP-specific authorization docs, and the OpenAI Apps SDK auth guidance points to an Auth0-authenticated MCP scaffold path. This keeps OAuth work on an established identity provider instead of a custom authorization server.
## Current Runtime Mode
The current MCP setup server remains no-auth and read-only.
```text
MCP_AUTH_ENABLED=0
MCP_AUTH_PROVIDER=auth0
safe_to_enable_oauth=no
```
Use ChatGPT Developer Mode with:
```text
Authentication: No Authentication
```
Do not select OAuth until the Auth0 tenant/API values are configured and verified.
## Required Auth0 Values
Placeholder-only variables live in `.env.example`.
```text
MCP_AUTH_ENABLED=0
MCP_AUTH_PROVIDER=auth0
MCP_PUBLIC_BASE_URL=
AUTH0_DOMAIN=
AUTH0_ISSUER=
AUTH0_AUDIENCE=
AUTH0_SCOPES=docs:read
```
Real values belong only in lo...
