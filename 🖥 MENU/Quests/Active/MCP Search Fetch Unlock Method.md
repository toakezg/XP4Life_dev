---
quest_id: QST-MCP-SEARCH-FETCH-UNLOCK-METHOD
name: "MCP Search Fetch Unlock Method"
status: completed
category: system
tier: rare
xp_reward: 300
achievement_unlocks:
  - MCP-SYS-005
title_reward: "Read Surface Keeper"
created: 2026-05-11
due:
progress_current: 5
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-search-fetch-unlock-method
tags:
  - quest
  - system
  - mcp
  - chatgpt-apps
  - testing
  - xp4l
---
# MCP Search Fetch Unlock Method

## Objective
Open the read gate without widening the bridge into a file browser. The method is simple: prove the gates, add only approved-document `search` and `fetch`, verify that secrets and arbitrary paths stay out, then carry the new surface back through the local and tunnel checks.

## Tasks
- [x] Confirm the unlocked gate state
  - [x] Verify `MCP-GATE-001` is set to `1`
  - [x] Verify the approved source list in `TOOL_SURFACE.md`
  - [x] Keep arbitrary path reads blocked
  - [x] Keep write-capable tools out of this pass
- [x] Implement bounded read tools
  - [x] Add `search` over approved docs only
  - [x] Add `fetch` for approved result ids only
  - [x] Keep `.env`, token files, and broad folders unreachable
  - [x] Update status and health metadata
- [x] Verify locally
  - [x] Restart the local MCP server
  - [x] Check local health
  - [x] Call `tools/list`
  - [x] Call `search`
  - [x] Call `fetch`
- [x] Verify the live relay surface
  - [x] Recheck the temporary `/mcp` URL
  - [x] Confirm `search` appears in `tools/list`
  - [x] Confirm `fetch` appears in `tools/list`
  - [x] Stop and record if the tunnel is stale
- [x] Record the method result
  - [x] Update `LOCAL_TESTING.md`
  - [x] Update `TASKS.md` and `CHANGELOG.md`
  - [x] Update `DCS_HANDOFF_PACKET.md`
  - [x] Update this quest with proof

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Confirm the unlocked gate state": "TASK_GATE",
  "Verify `MCP-GATE-001` is set to `1`": "TASK_GATE_1",
  "Verify the approved source list in `TOOL_SURFACE.md`": "TASK_GATE_2",
  "Keep arbitrary path reads blocked": "TASK_GATE_3",
  "Keep write-capable tools out of this pass": "TASK_GATE_4",
  "Implement bounded read tools": "TASK_IMPL",
  "Add `search` over approved docs only": "TASK_IMPL_1",
  "Add `fetch` for approved result ids only": "TASK_IMPL_2",
  "Keep `.env`, token files, and broad folders unreachable": "TASK_IMPL_3",
  "Update status and health metadata": "TASK_IMPL_4",
  "Verify locally": "TASK_LOCAL",
  "Restart the local MCP server": "TASK_LOCAL_1",
  "Check local health": "TASK_LOCAL_2",
  "Call `tools/list`": "TASK_LOCAL_3",
  "Call `search`": "TASK_LOCAL_4",
  "Call `fetch`": "TASK_LOCAL_5",
  "Verify the live relay surface": "TASK_RELAY",
  "Recheck the temporary `/mcp` URL": "TASK_RELAY_1",
  "Confirm `search` appears in `tools/list`": "TASK_RELAY_2",
  "Confirm `fetch` appears in `tools/list`": "TASK_RELAY_3",
  "Stop and record if the tunnel is stale": "TASK_RELAY_4",
  "Record the method result": "TASK_RECORD",
  "Update `LOCAL_TESTING.md`": "TASK_RECORD_1",
  "Update `TASKS.md` and `CHANGELOG.md`": "TASK_RECORD_2",
  "Update `DCS_HANDOFF_PACKET.md`": "TASK_RECORD_3",
  "Update this quest with proof": "TASK_RECORD_4"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_GATE[Confirm unlocked gate state] --> TASK_GATE_1[Gate 001 is 1]
    TASK_GATE --> TASK_GATE_2[Approved source list]
    TASK_GATE --> TASK_GATE_3[Block arbitrary paths]
    TASK_GATE --> TASK_GATE_4[No write tools this pass]
    TASK_GATE --> TASK_IMPL[Implement bounded read tools]
    TASK_IMPL --> TASK_IMPL_1[Add search]
    TASK_IMPL --> TASK_IMPL_2[Add fetch]
    TASK_IMPL --> TASK_IMPL_3[Keep secrets unreachable]
    TASK_IMPL --> TASK_IMPL_4[Update metadata]
    TASK_IMPL --> TASK_LOCAL[Verify locally]
    TASK_LOCAL --> TASK_LOCAL_1[Restart server]
    TASK_LOCAL --> TASK_LOCAL_2[Health]
    TASK_LOCAL --> TASK_LOCAL_3[tools/list]
    TASK_LOCAL --> TASK_LOCAL_4[search]
    TASK_LOCAL --> TASK_LOCAL_5[fetch]
    TASK_LOCAL --> TASK_RELAY[Verify relay]
    TASK_RELAY --> TASK_RELAY_1[Recheck /mcp URL]
    TASK_RELAY --> TASK_RELAY_2[search in tools/list]
    TASK_RELAY --> TASK_RELAY_3[fetch in tools/list]
    TASK_RELAY --> TASK_RELAY_4[Record stale tunnel if needed]
    TASK_RELAY --> TASK_RECORD[Record method result]
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
  "Confirm the unlocked gate state": ["GATE", "SOURCES", "BOUNDARY"],
  "Implement bounded read tools": ["SEARCH", "FETCH", "NO_SECRETS"],
  "Verify locally": ["LOCAL_HEALTH", "LOCAL_TOOLS", "LOCAL_SEARCH_FETCH"],
  "Verify the live relay surface": ["RELAY", "RELAY_TOOLS"],
  "Record the method result": ["RECORD", "QUEST"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    GATE[Read updated GATE.md] --> SOURCES[Read TOOL_SURFACE approved sources]
    SOURCES --> BOUNDARY[No arbitrary path, no secrets, no writes]
    BOUNDARY --> SEARCH[Implement approved-doc search]
    SEARCH --> FETCH[Implement approved-id fetch]
    FETCH --> NO_SECRETS[Keep env and token files unreachable]
    NO_SECRETS --> LOCAL_HEALTH[Restart and check local health]
    LOCAL_HEALTH --> LOCAL_TOOLS[Local tools/list shows status, list_sources, search, fetch]
    LOCAL_TOOLS --> LOCAL_SEARCH_FETCH[Local search and fetch pass]
    LOCAL_SEARCH_FETCH --> RELAY[Recheck temporary /mcp relay]
    RELAY --> RELAY_TOOLS[Relay tools/list includes search and fetch]
    RELAY_TOOLS --> RECORD[Update MCP docs and task state]
    RECORD --> QUEST[Update XP4Life quest proof]

    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 300
- Achievement Unlocks: MCP-SYS-005
- Title Reward: Read Surface Keeper

## Completion Proof
- Local `tools/list` includes `status`, `list_sources`, `search`, and `fetch`.
- `search` returns only approved-document result ids.
- `fetch` returns only approved-document content by approved id.
- `.env`, token paths, arbitrary local paths, and broad folders remain unreachable.
- `LOCAL_TESTING.md`, `TASKS.md`, `CHANGELOG.md`, and `DCS_HANDOFF_PACKET.md` record the result.

Proof paths:

```text
runs\search-fetch\20260511T-local-search-fetch
runs\tunnel\20260511T005717-search-fetch-relay
```

Verified relay URL:

```text
https://fair-ties-chew.loca.lt/mcp
```

Result:

```text
tools/list: status, list_sources, search, fetch
search: passed over approved docs
fetch approved source: passed
fetch .env: denied with empty text
refreshed relay: runs\tunnel\20260511T010138-search-fetch-relay-refresh
```

## Source Notes
- `F:\servers\mcp\GATE.md`
- `F:\servers\mcp\docs\reference\TOOL_SURFACE.md`
- `F:\servers\mcp\docs\reference\SECURITY_GATES.md`
- `F:\servers\mcp\docs\reference\LOCAL_TESTING.md`
- `F:\servers\mcp\servers\active\mcp-setup-server\server.js`

## Notes
- Hand-authored from the unlocked Gate 001 workflow using `$create-quest-from-workflow`.
- The method intentionally opens only bounded read tools first; write-capable tools remain separate until a named tool brief exists.
