---
quest_id: QST-MCP-LOCAL-CONNECTION-TRIAL
name: "MCP Local Connection Trial"
status: active
category: system
tier: rare
xp_reward: 320
achievement_unlocks:
  - MCP-SYS-003
title_reward: "Endpoint Runner"
created: 2026-05-10
due:
progress_current: 6
progress_target: 8
quest_type: manual
xp4l_rule_id: mcp-local-connection-trial
tags:
  - quest
  - system
  - mcp
  - chatgpt-apps
  - testing
  - xp4l
---
# MCP Local Connection Trial

## Objective
Bring the bridge alive without over-opening the gate. Start localhost, prove `/mcp`, inspect the tools, tunnel only after local success, then connect ChatGPT and write down what actually happened.

## Tasks
- [x] Prepare the local server
  - [x] Create or adapt the smallest MCP server
  - [x] Keep the first tool read-only or dry-run-first
  - [x] Start the server on a known localhost port
- [x] Verify localhost
  - [x] Check the health route
  - [x] Check the `/mcp` endpoint
  - [x] Record command output in `LOCAL_TESTING.md`
- [x] Inspect the MCP surface
  - [x] Run MCP Inspector
  - [x] Confirm tool listing
  - [x] Call the first tool with a safe input
  - [x] Record any schema or transport failures
- [x] Open the HTTPS tunnel
  - [x] Start ngrok or Cloudflare Tunnel
  - [x] Confirm the public URL reaches only the intended endpoint
  - [x] Record the temporary URL without secrets
- [x] Rerun Gate 009 live connector smoke
  - [x] Replace the stale temporary tunnel
  - [x] Verify public health and MCP initialize
  - [x] Verify `tools/list`, `status`, and `list_sources`
  - [x] Record the run under `runs\live-connection`
- [x] Prepare the ChatGPT Developer Mode packet
  - [x] Record the approved `status` prompt
  - [x] Record the approved `list_sources` prompt
  - [x] Record blocked `search`, secret-read, and write-action prompts
- [ ] Retry a healthy Gate 003 tunnel
  - [ ] Start a fresh temporary HTTPS tunnel
  - [ ] Verify public health and `/mcp` initialize
  - [ ] Stop if the tunnel returns 503, 408, or timeout
- [ ] Connect ChatGPT Developer Mode
  - [ ] Add the HTTPS `/mcp` URL
  - [ ] Refresh after metadata changes
  - [ ] Run direct, follow-up, and negative prompts
  - [ ] Record pass/fail results

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();
const doneByText = Object.fromEntries(allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const taskNodes = {
  "Prepare the local server": "PREP",
  "Create or adapt the smallest MCP server": "PREP_1",
  "Keep the first tool read-only or dry-run-first": "PREP_2",
  "Start the server on a known localhost port": "PREP_3",
  "Verify localhost": "LOCAL",
  "Check the health route": "LOCAL_1",
  "Check the `/mcp` endpoint": "LOCAL_2",
  "Record command output in `LOCAL_TESTING.md`": "LOCAL_3",
  "Inspect the MCP surface": "INSPECT",
  "Run MCP Inspector": "INSPECT_1",
  "Confirm tool listing": "INSPECT_2",
  "Call the first tool with a safe input": "INSPECT_3",
  "Record any schema or transport failures": "INSPECT_4",
  "Open the HTTPS tunnel": "TUNNEL",
  "Start ngrok or Cloudflare Tunnel": "TUNNEL_1",
  "Confirm the public URL reaches only the intended endpoint": "TUNNEL_2",
  "Record the temporary URL without secrets": "TUNNEL_3",
  "Connect ChatGPT Developer Mode": "CHATGPT",
  "Add the HTTPS `/mcp` URL": "CHATGPT_1",
  "Refresh after metadata changes": "CHATGPT_2",
  "Run direct, follow-up, and negative prompts": "CHATGPT_3",
  "Record pass/fail results": "CHATGPT_4"
};
const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) if (doneByText[taskText]) doneNodes.push(nodeId);
dv.paragraph(`Task map progress: **${allTasks.filter(t => t.completed).length}/${allTasks.length}** checklist items complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    PREP[Prepare the local server] --> PREP_1[Create or adapt smallest MCP server]
    PREP --> PREP_2[First tool read-only or dry-run-first]
    PREP --> PREP_3[Start localhost port]
    PREP --> LOCAL[Verify localhost]
    LOCAL --> LOCAL_1[Health route]
    LOCAL --> LOCAL_2[/mcp endpoint]
    LOCAL --> LOCAL_3[Record output]
    LOCAL --> INSPECT[Inspect MCP surface]
    INSPECT --> INSPECT_1[MCP Inspector]
    INSPECT --> INSPECT_2[Tool listing]
    INSPECT --> INSPECT_3[Safe tool call]
    INSPECT --> INSPECT_4[Record failures]
    INSPECT --> TUNNEL[Open HTTPS tunnel]
    TUNNEL --> TUNNEL_1[Start tunnel]
    TUNNEL --> TUNNEL_2[Confirm intended endpoint]
    TUNNEL --> TUNNEL_3[Record temporary URL]
    TUNNEL --> CHATGPT[Connect ChatGPT Developer Mode]
    CHATGPT --> CHATGPT_1[Add HTTPS /mcp URL]
    CHATGPT --> CHATGPT_2[Refresh metadata]
    CHATGPT --> CHATGPT_3[Run prompt set]
    CHATGPT --> CHATGPT_4[Record pass/fail]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Workflow Map
```dataviewjs
const topTasks = dv.current().file.tasks.where(t => !t.parent).array();
const doneByText = Object.fromEntries(topTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const stageNodes = {
  "Prepare the local server": ["S1", "S2"],
  "Verify localhost": ["S3", "S4"],
  "Inspect the MCP surface": ["S5"],
  "Open the HTTPS tunnel": ["S8"],
  "Connect ChatGPT Developer Mode": ["S9", "S10", "S11"]
};
const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) if (doneByText[taskText]) doneNodes.push(...nodes);
dv.paragraph(`Workflow progress: **${topTasks.filter(t => t.completed).length}/${topTasks.length}** task groups complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    S1[Choose first MCP server shape] --> S2[Define one read-only or dry-run-first tool]
    S2 --> S3[Run local MCP server]
    S3 --> S4[Verify localhost /mcp]
    S4 --> S5[Test with MCP Inspector]
    S5 --> S6{Local test passed?}
    S6 -- no --> S7[Fix server, schema, or transport]
    S7 --> S3
    S6 -- yes --> S8[Expose through HTTPS tunnel]
    S8 --> S9[Connect in ChatGPT Developer Mode]
    S9 --> S10[Run direct, follow-up, and negative prompts]
    S10 --> S11[Record results in reference docs]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 320
- Achievement Unlocks: MCP-SYS-003
- Title Reward: Endpoint Runner

## Completion Proof
- A local MCP server runs on a known port.
- MCP Inspector lists and calls the first tool.
- ChatGPT Developer Mode reaches the tunneled `/mcp` endpoint.
- `LOCAL_TESTING.md` records the prompt set and pass/fail result.

## Source Notes
- `F:\servers\mcp\docs\reference\PLAN.md`
- `F:\servers\mcp\docs\reference\DIAGRAMS.md`
- `F:\servers\mcp\docs\dcs\mcp-setup.md`

## Notes
- Hand-authored from the MCP setup workflow using `$create-quest-from-workflow`.
- This quest should wait until the tool surface and safety gates are documented.
