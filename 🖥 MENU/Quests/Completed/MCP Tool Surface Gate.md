---
quest_id: QST-MCP-TOOL-SURFACE-GATE
user: toakezg
name: MCP Tool Surface Gate
status: complete
category: system
tier: uncommon
xp_reward: 240
achievement_unlocks:
  - MCP-SYS-002
title_reward: Tool Gatekeeper
created: 2026-05-10
due:
progress_current: 5
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-tool-surface-gate
tags:
  - quest
  - system
  - mcp
  - safety
  - xp4l
quest_requirements:
completed_on: 2026-11-05

---
# MCP Tool Surface Gate

## Objective
Choose the first MCP tools like a careful operator: boring, provable, read-only or dry-run-first. The gate opens only when the tool names, schemas, sources, and safety hints are written plainly enough to test.

## Tasks
- [x] Pick the first archetype
  - [x] Decide `tool-only` or `data-only`
  - [x] Reject widget UI unless a clear need appears
  - [x] Record why this archetype fits the first test
- [ ] Define the candidate tools
  - [x] Add `status`
  - [x] Add `list_sources`
  - [x] Add `search` and `fetch` only if source docs are indexed ✅ 2026-05-11
  - [x] Keep any action as dry-run-first
- [x] Write safety gates
  - [x] Mark every tool read-only or not read-only
  - [x] Mark destructive and open-world behavior honestly
  - [x] Define what local paths may be read
  - [x] Define what must never be exposed
- [x] Prepare verification prompts
  - [x] Add one direct prompt
  - [x] Add one follow-up prompt
  - [x] Add one negative prompt
  - [x] Add expected pass/fail behavior
- [x] Preserve the current gated tool surface after Gates 009-012
  - [x] Keep the live connector limited to `status` and `list_sources`
  - [x] Leave `search` and `fetch` blocked under `MCP-GATE-001`
  - [x] Require a named brief before any write-capable MCP tool

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();
const doneByText = Object.fromEntries(allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const taskNodes = {
  "Pick the first archetype": "ARCH",
  "Decide `tool-only` or `data-only`": "ARCH_1",
  "Reject widget UI unless a clear need appears": "ARCH_2",
  "Record why this archetype fits the first test": "ARCH_3",
  "Define the candidate tools": "TOOLS",
  "Add `status`": "TOOLS_1",
  "Add `list_sources`": "TOOLS_2",
  "Add `search` and `fetch` only if source docs are indexed": "TOOLS_3",
  "Keep any action as dry-run-first": "TOOLS_4",
  "Write safety gates": "SAFETY",
  "Mark every tool read-only or not read-only": "SAFETY_1",
  "Mark destructive and open-world behavior honestly": "SAFETY_2",
  "Define what local paths may be read": "SAFETY_3",
  "Define what must never be exposed": "SAFETY_4",
  "Prepare verification prompts": "VERIFY",
  "Add one direct prompt": "VERIFY_1",
  "Add one follow-up prompt": "VERIFY_2",
  "Add one negative prompt": "VERIFY_3",
  "Add expected pass/fail behavior": "VERIFY_4"
};
const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) if (doneByText[taskText]) doneNodes.push(nodeId);
dv.paragraph(`Task map progress: **${allTasks.filter(t => t.completed).length}/${allTasks.length}** checklist items complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    ARCH[Pick the first archetype] --> ARCH_1[Decide tool-only or data-only]
    ARCH --> ARCH_2[Reject widget UI unless needed]
    ARCH --> ARCH_3[Record fit]
    ARCH --> TOOLS[Define candidate tools]
    TOOLS --> TOOLS_1[status]
    TOOLS --> TOOLS_2[list_sources]
    TOOLS --> TOOLS_3[search and fetch if indexed]
    TOOLS --> TOOLS_4[dry-run-first actions]
    TOOLS --> SAFETY[Write safety gates]
    SAFETY --> SAFETY_1[read-only status]
    SAFETY --> SAFETY_2[destructive and open-world status]
    SAFETY --> SAFETY_3[allowed local paths]
    SAFETY --> SAFETY_4[never expose list]
    SAFETY --> VERIFY[Prepare verification prompts]
    VERIFY --> VERIFY_1[direct prompt]
    VERIFY --> VERIFY_2[follow-up prompt]
    VERIFY --> VERIFY_3[negative prompt]
    VERIFY --> VERIFY_4[expected behavior]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Workflow Map
```dataviewjs
const topTasks = dv.current().file.tasks.where(t => !t.parent).array();
const doneByText = Object.fromEntries(topTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const stageNodes = {
  "Pick the first archetype": ["A1"],
  "Define the candidate tools": ["A2"],
  "Write safety gates": ["A3"],
  "Prepare verification prompts": ["A4"]
};
const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) if (doneByText[taskText]) doneNodes.push(...nodes);
dv.paragraph(`Workflow progress: **${topTasks.filter(t => t.completed).length}/${topTasks.length}** task groups complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    A1[Choose tool-only or data-only] --> A2[Name first tools]
    A2 --> A3[Write security gates]
    A3 --> A4[Prepare test prompts]
    A4 --> A5[Ready for local server implementation]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 240
- Achievement Unlocks: MCP-SYS-002
- Title Reward: Tool Gatekeeper

## Completion Proof
- `TOOL_SURFACE.md` names the first tool set and schemas.
- `SECURITY_GATES.md` describes read/write, destructive, open-world, path, and secret boundaries.
- `LOCAL_TESTING.md` contains direct, follow-up, and negative prompt cases.

## Source Notes
- `F:\servers\mcp\docs\reference\PLAN.md`
- `F:\servers\mcp\docs\dcs\mcp-setup.md`

## Notes
- Hand-authored from the MCP setup workflow using `$create-quest-from-workflow`.
- Complete this before implementing a live MCP server.
