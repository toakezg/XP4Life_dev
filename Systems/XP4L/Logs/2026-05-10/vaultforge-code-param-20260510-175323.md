---
note_type: xp4l_log
xp4l_generated: true
materialized_by: vaultforge-xp4l
event_id: vaultforge-code-param-20260510-175323
timestamp: 2026-05-10T17:53:23+00:00
day: 2026-05-10
source: vaultforge-code
event_type: file_summary_logged
category: general
action: "param("
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
# Event vaultforge-code-param-20260510-175323

## Summary

- Timestamp: 2026-05-10T17:53:23+00:00
- Source: vaultforge-code
- Type: file_summary_logged
- Category: general
- Action: param(
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

- source_file: F:\servers\mcp\scripts\run-connector-smoke.ps1
- text: param(
  [string]$Endpoint = "http://127.0.0.1:8787/mcp",
  [string]$RunRoot = "runs\connector-smoke",
  [string]$SearchQuery = "ChatGPT Developer Mode",
  [string]$FetchId = "reference-tool-surface",
  [string]$ManifestId = "mcp-setup-current",
  [string]$DryRunTitle = "MCP Dry Run Smoke Doc",
  [int]$TimeoutSec = 20
)
$ErrorActionPreference = "Stop"
function New-JsonRpcPayload {
  param(
    [string]$Id,
    [string]$Method,
    [object]$Params = $null
  )
  $payload = [ordered]@{
    jsonrpc = "2.0"
    id = $Id
    method = $Method
  }
  if ($null -ne $Params) {
    $payload.params = $Params
  }
  return $payload
}
function Invoke-McpRequest {
  param(
    [string]$Name,
    [object]$Payload,
    [string]$OutDir
  )
  $requestPath = Join-Path $OutDir "$Name.request.json"
  $responsePath = Join-Path $OutDir "$Name.response.json"
  $body = $Payload | ConvertTo-Json -Depth 30
  $body...
