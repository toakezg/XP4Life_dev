---
quest_id: QST-MCP-DEVELOPER-MODE-RELAY
user: toakezg
name: "MCP Developer Mode Relay"
status: active
category: system
tier: rare
xp_reward: 280
achievement_unlocks:
  - MCP-SYS-004
title_reward: "Relay Operator"
created: 2026-05-11
due:
progress_current: 3
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-developer-mode-relay
tags:
  - quest
  - system
  - mcp
  - chatgpt-apps
  - testing
  - xp4l

---
# MCP Developer Mode Relay

## Objective
Carry the MCP bridge across the last live-connection gap. Keep the gate narrow, prove localhost first, raise only one temporary HTTPS relay, then let ChatGPT Developer Mode touch the current `status` and `list_sources` surface without opening search, secrets, writes, or paid calls.

## Tasks
- [x] Recheck the gate board
  - [x] Confirm `MCP-GATE-001` still blocks `search` and `fetch`
  - [x] Confirm `MCP-GATE-002` allows one temporary HTTPS tunnel
  - [x] Confirm `MCP-GATE-003` allows one Developer Mode prompt test
  - [x] Confirm no write-capable tool brief exists for `MCP-GATE-004`
- [x] Prove local MCP health
  - [x] Check `http://127.0.0.1:8787/`
  - [x] Confirm the server reports `local-read-only`
  - [x] Confirm the tools are only `status` and `list_sources`
- [x] Raise a clean temporary tunnel
  - [x] Start one tunnel to `127.0.0.1:8787`
  - [x] Verify public health returns the MCP setup server
  - [x] Verify public `/mcp` initialize succeeds
  - [ ] Stop and record the blocker if the tunnel returns 503, 408, or timeout
- [ ] Run the Developer Mode prompt packet
  - [x] Add the healthy temporary `/mcp` URL in ChatGPT Developer Mode
  - [ ] Run the `status` prompt
  - [ ] Run the `list_sources` prompt
  - [ ] Run the blocked `search`, secret-read, and write-action prompts
- [ ] Record the relay result
  - [ ] Update `LOCAL_TESTING.md`
  - [ ] Update `TASKS.md` and `CHANGELOG.md`
  - [ ] Update `DCS_HANDOFF_PACKET.md`
  - [ ] Update this quest with pass/fail proof

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Recheck the gate board": "TASK_GATE",
  "Confirm `MCP-GATE-001` still blocks `search` and `fetch`": "TASK_GATE_1",
  "Confirm `MCP-GATE-002` allows one temporary HTTPS tunnel": "TASK_GATE_2",
  "Confirm `MCP-GATE-003` allows one Developer Mode prompt test": "TASK_GATE_3",
  "Confirm no write-capable tool brief exists for `MCP-GATE-004`": "TASK_GATE_4",
  "Prove local MCP health": "TASK_LOCAL",
  "Check `http://127.0.0.1:8787/`": "TASK_LOCAL_1",
  "Confirm the server reports `local-read-only`": "TASK_LOCAL_2",
  "Confirm the tools are only `status` and `list_sources`": "TASK_LOCAL_3",
  "Raise a clean temporary tunnel": "TASK_TUNNEL",
  "Start one tunnel to `127.0.0.1:8787`": "TASK_TUNNEL_1",
  "Verify public health returns the MCP setup server": "TASK_TUNNEL_2",
  "Verify public `/mcp` initialize succeeds": "TASK_TUNNEL_3",
  "Stop and record the blocker if the tunnel returns 503, 408, or timeout": "TASK_TUNNEL_4",
  "Run the Developer Mode prompt packet": "TASK_PACKET",
  "Add the healthy temporary `/mcp` URL in ChatGPT Developer Mode": "TASK_PACKET_1",
  "Run the `status` prompt": "TASK_PACKET_2",
  "Run the `list_sources` prompt": "TASK_PACKET_3",
  "Run the blocked `search`, secret-read, and write-action prompts": "TASK_PACKET_4",
  "Record the relay result": "TASK_RECORD",
  "Update `LOCAL_TESTING.md`": "TASK_RECORD_1",
  "Update `TASKS.md` and `CHANGELOG.md`": "TASK_RECORD_2",
  "Update `DCS_HANDOFF_PACKET.md`": "TASK_RECORD_3",
  "Update this quest with pass/fail proof": "TASK_RECORD_4"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_GATE[Recheck the gate board] --> TASK_GATE_1[Gate 001 blocks search/fetch]
    TASK_GATE --> TASK_GATE_2[Gate 002 allows one tunnel]
    TASK_GATE --> TASK_GATE_3[Gate 003 allows one Developer Mode test]
    TASK_GATE --> TASK_GATE_4[No Gate 004 write-tool brief]
    TASK_GATE --> TASK_LOCAL[Prove local MCP health]
    TASK_LOCAL --> TASK_LOCAL_1[Check localhost health]
    TASK_LOCAL --> TASK_LOCAL_2[Confirm local-read-only mode]
    TASK_LOCAL --> TASK_LOCAL_3[Confirm status and list_sources only]
    TASK_LOCAL --> TASK_TUNNEL[Raise a clean temporary tunnel]
    TASK_TUNNEL --> TASK_TUNNEL_1[Start one tunnel]
    TASK_TUNNEL --> TASK_TUNNEL_2[Verify public health]
    TASK_TUNNEL --> TASK_TUNNEL_3[Verify public /mcp initialize]
    TASK_TUNNEL --> TASK_TUNNEL_4[Stop on 503, 408, or timeout]
    TASK_TUNNEL --> TASK_PACKET[Run the Developer Mode prompt packet]
    TASK_PACKET --> TASK_PACKET_1[Add healthy /mcp URL]
    TASK_PACKET --> TASK_PACKET_2[Run status prompt]
    TASK_PACKET --> TASK_PACKET_3[Run list_sources prompt]
    TASK_PACKET --> TASK_PACKET_4[Run blocked prompts]
    TASK_PACKET --> TASK_RECORD[Record the relay result]
    TASK_RECORD --> TASK_RECORD_1[Update LOCAL_TESTING.md]
    TASK_RECORD --> TASK_RECORD_2[Update TASKS.md and CHANGELOG.md]
    TASK_RECORD --> TASK_RECORD_3[Update DCS_HANDOFF_PACKET.md]
    TASK_RECORD --> TASK_RECORD_4[Update quest proof]

    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Workflow Map
```dataviewjs
const topTasks = dv.current().file.tasks
  .where(t => !t.parent)
  .array();

const doneByText = Object.fromEntries(
  topTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const stageNodes = {
  "Recheck the gate board": ["GATE", "BLOCKED_SEARCH", "NO_WRITE"],
  "Prove local MCP health": ["LOCAL", "SURFACE"],
  "Raise a clean temporary tunnel": ["TUNNEL", "PUBLIC_HEALTH", "MCP_INIT", "TUNNEL_BLOCKER"],
  "Run the Developer Mode prompt packet": ["DEVMODE", "PROMPTS", "NEGATIVE_PROMPTS"],
  "Record the relay result": ["RECORD", "QUEST"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    GATE[Read GATE.md] --> BLOCKED_SEARCH[Keep search and fetch blocked]
    GATE --> NO_WRITE[No write-capable MCP tool without named brief]
    BLOCKED_SEARCH --> LOCAL[Verify localhost MCP health]
    NO_WRITE --> LOCAL
    LOCAL --> SURFACE[Confirm status and list_sources only]
    SURFACE --> TUNNEL[Start one temporary HTTPS tunnel]
    TUNNEL --> PUBLIC_HEALTH[Check public health route]
    PUBLIC_HEALTH --> MCP_INIT[Check public /mcp initialize]
    MCP_INIT --> TUNNEL_OK{Tunnel healthy?}
    TUNNEL_OK -- no --> TUNNEL_BLOCKER[Record 503, 408, timeout, or wrong endpoint]
    TUNNEL_BLOCKER --> RECORD[Update docs and task state]
    TUNNEL_OK -- yes --> DEVMODE[Connect ChatGPT Developer Mode]
    DEVMODE --> PROMPTS[Run status and list_sources prompts]
    PROMPTS --> NEGATIVE_PROMPTS[Run blocked search, secret, and write prompts]
    NEGATIVE_PROMPTS --> RECORD
    RECORD --> QUEST[Update XP4Life quest proof]

    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 280
- Achievement Unlocks: MCP-SYS-004
- Title Reward: Relay Operator

## Completion Proof
- `LOCAL_TESTING.md` shows local health, public tunnel health, and `/mcp` initialize results.
- `CHATGPT_DEVELOPER_MODE_TEST_PACKET.md` prompts are run or explicitly blocked by a recorded tunnel failure.
- `TASKS.md`, `CHANGELOG.md`, and `DCS_HANDOFF_PACKET.md` are updated with the final pass/fail state.
- This quest records whether the relay ended in ChatGPT Developer Mode success or a truthful tunnel-provider blocker.

Current relay:

```text
https://fair-ties-chew.loca.lt/mcp
```

Current proof:

```text
runs\tunnel\20260511T003801-gate003-relay-retry
public health: passed
public /mcp initialize: passed
tools/list: passed
status: passed
list_sources: passed
```

Latest workflow cycle:

```text
runs\workflow\20260511T-cycle2-budget15
local MCP health: passed
public health route: flaky, timed out once
public /mcp tools/list: passed
public /mcp status: passed
public /mcp list_sources: passed
stopped at manual ChatGPT Developer Mode boundary
```

Search/fetch relay update:

```text
runs\tunnel\20260511T005717-search-fetch-relay
tools/list: status, list_sources, search, fetch
search: passed
fetch: passed
fetch .env: denied
current refreshed relay: runs\tunnel\20260511T010138-search-fetch-relay-refresh
```

## Source Notes
- `F:\servers\mcp\GATE.md`
- `F:\servers\mcp\WORKFLOW_B_MCP_PLAN.md`
- `F:\servers\mcp\docs\reference\CHATGPT_DEVELOPER_MODE_TEST_PACKET.md`
- `F:\servers\mcp\docs\reference\LOCAL_TESTING.md`
- `F:\servers\mcp\docs\dcs\DCS_HANDOFF_PACKET.md`
- `F:\XP4Life\🖥 MENU\Quests\Active\MCP Local Connection Trial.md`

## Notes
- Hand-authored from the MCP Gate 003 retry workflow using `$create-quest-from-workflow -write`.
- Plugins are optional enhancement layers; the quest remains plain Obsidian Markdown with YAML as source of truth.
- The embedded workflow graph is the Gate 003 relay path extracted from the current MCP workflow packet and Developer Mode test packet.
