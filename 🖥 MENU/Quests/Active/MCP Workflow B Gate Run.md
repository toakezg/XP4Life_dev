---
quest_id: QST-MCP-WORKFLOW-B-GATE-RUN
name: "MCP Workflow B Gate Run"
status: active
category: system
tier: rare
xp_reward: 300
achievement_unlocks:
  - MCP-SYS-005
title_reward: "Gate Run Operator"
created: 2026-05-11
due:
progress_current: 0
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-workflow-b-gate-run
tags:
  - quest
  - system
  - mcp
  - workflow-b
  - gates
  - xp4l
---
# MCP Workflow B Gate Run

## Objective
Take the MCP workspace through one bounded Workflow B-style run without widening the tool surface by accident. Read the gates first, move only through approved lanes, prove each connection or setup step with artifacts, and stop before paid API calls or unapproved implementation work.

## Tasks
- [ ] Read the gate surface
  - [ ] Review `F:\servers\mcp\GATE.md`
  - [ ] Treat blank gates as blocked
  - [ ] Confirm `MCP-GATE-001` still blocks search and fetch
  - [ ] Confirm `MCP-GATE-008` allows only local secret setup and presence checks
- [ ] Select the approved run lane
  - [ ] Read `F:\servers\mcp\WORKFLOW_B_MCP_PLAN.md`
  - [ ] List approved work for the next bounded cycle
  - [ ] List blocked work before touching code
  - [ ] Keep write tools, widget UI, public hosting, automation, and paid calls out of scope unless an exact gate brief names them
- [ ] Verify the current MCP baseline
  - [ ] Check the local server health path
  - [ ] Verify `tools/list`
  - [ ] Verify `status`
  - [ ] Verify `list_sources`
  - [ ] Record any Windows MCP Inspector limitation honestly
- [ ] Run only approved connection or setup checks
  - [ ] If tunnel work is selected, verify local health before tunnel exposure
  - [ ] If Developer Mode work is selected, use only the approved `/mcp` URL and prompt packet
  - [ ] If secret setup is selected, verify key presence without printing key values
  - [ ] Stop before the first paid OpenAI API smoke call unless `OPENAI_API_PAID_USAGE_APPROVED=1`
- [ ] Update the durable handoff
  - [ ] Update `LOCAL_TESTING.md` with pass/fail evidence
  - [ ] Update `TASKS.md` with completed and blocked items
  - [ ] Update `CHANGELOG.md` if project behavior or setup state changed
  - [ ] Update `docs\dcs\DCS_HANDOFF_PACKET.md` with the next bounded prompt
  - [ ] Leave a clean stop state for the next operator

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();
const doneByText = Object.fromEntries(allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const taskNodes = {
  "Read the gate surface": "GATE",
  "Review `F:\\servers\\mcp\\GATE.md`": "GATE_1",
  "Treat blank gates as blocked": "GATE_2",
  "Confirm `MCP-GATE-001` still blocks search and fetch": "GATE_3",
  "Confirm `MCP-GATE-008` allows only local secret setup and presence checks": "GATE_4",
  "Select the approved run lane": "LANE",
  "Read `F:\\servers\\mcp\\WORKFLOW_B_MCP_PLAN.md`": "LANE_1",
  "List approved work for the next bounded cycle": "LANE_2",
  "List blocked work before touching code": "LANE_3",
  "Keep write tools, widget UI, public hosting, automation, and paid calls out of scope unless an exact gate brief names them": "LANE_4",
  "Verify the current MCP baseline": "BASE",
  "Check the local server health path": "BASE_1",
  "Verify `tools/list`": "BASE_2",
  "Verify `status`": "BASE_3",
  "Verify `list_sources`": "BASE_4",
  "Record any Windows MCP Inspector limitation honestly": "BASE_5",
  "Run only approved connection or setup checks": "RUN",
  "If tunnel work is selected, verify local health before tunnel exposure": "RUN_1",
  "If Developer Mode work is selected, use only the approved `/mcp` URL and prompt packet": "RUN_2",
  "If secret setup is selected, verify key presence without printing key values": "RUN_3",
  "Stop before the first paid OpenAI API smoke call unless `OPENAI_API_PAID_USAGE_APPROVED=1`": "RUN_4",
  "Update the durable handoff": "HANDOFF",
  "Update `LOCAL_TESTING.md` with pass/fail evidence": "HANDOFF_1",
  "Update `TASKS.md` with completed and blocked items": "HANDOFF_2",
  "Update `CHANGELOG.md` if project behavior or setup state changed": "HANDOFF_3",
  "Update `docs\\dcs\\DCS_HANDOFF_PACKET.md` with the next bounded prompt": "HANDOFF_4",
  "Leave a clean stop state for the next operator": "HANDOFF_5"
};
const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) if (doneByText[taskText]) doneNodes.push(nodeId);
dv.paragraph(`Task map progress: **${allTasks.filter(t => t.completed).length}/${allTasks.length}** checklist items complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    GATE[Read the gate surface] --> GATE_1[Review GATE.md]
    GATE --> GATE_2[Treat blank gates as blocked]
    GATE --> GATE_3[Confirm search/fetch blocked]
    GATE --> GATE_4[Confirm secret setup boundary]
    GATE --> LANE[Select the approved run lane]
    LANE --> LANE_1[Read WORKFLOW_B_MCP_PLAN.md]
    LANE --> LANE_2[List approved work]
    LANE --> LANE_3[List blocked work]
    LANE --> LANE_4[Keep broad work out of scope]
    LANE --> BASE[Verify the current MCP baseline]
    BASE --> BASE_1[Check local health]
    BASE --> BASE_2[Verify tools/list]
    BASE --> BASE_3[Verify status]
    BASE --> BASE_4[Verify list_sources]
    BASE --> BASE_5[Record Inspector limitation]
    BASE --> RUN[Run only approved checks]
    RUN --> RUN_1[Tunnel only after local health]
    RUN --> RUN_2[Developer Mode approved URL]
    RUN --> RUN_3[Secret presence without value exposure]
    RUN --> RUN_4[Stop before paid smoke call]
    RUN --> HANDOFF[Update the durable handoff]
    HANDOFF --> HANDOFF_1[Update LOCAL_TESTING.md]
    HANDOFF --> HANDOFF_2[Update TASKS.md]
    HANDOFF --> HANDOFF_3[Update CHANGELOG.md]
    HANDOFF --> HANDOFF_4[Update DCS_HANDOFF_PACKET.md]
    HANDOFF --> HANDOFF_5[Clean stop state]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Workflow Map
```dataviewjs
const topTasks = dv.current().file.tasks.where(t => !t.parent).array();
const doneByText = Object.fromEntries(topTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const stageNodes = {
  "Read the gate surface": ["A", "B"],
  "Select the approved run lane": ["C", "D"],
  "Verify the current MCP baseline": ["E", "F"],
  "Run only approved connection or setup checks": ["G", "H", "I"],
  "Update the durable handoff": ["J", "K"]
};
const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) if (doneByText[taskText]) doneNodes.push(...nodes);
dv.paragraph(`Workflow progress: **${topTasks.filter(t => t.completed).length}/${topTasks.length}** task groups complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    A[Read GATE.md] --> B{Gate approved?}
    B -- no or blank --> K[Stop with blocked note]
    B -- yes --> C[Read Workflow B plan]
    C --> D[Choose safe approved lane]
    D --> E[Verify local MCP baseline]
    E --> F{Baseline healthy?}
    F -- no --> J[Record failure and next fix]
    F -- yes --> G{Selected lane}
    G --> H[Tunnel or Developer Mode check]
    G --> I[Local secret presence check]
    H --> J[Update testing and handoff docs]
    I --> J
    J --> K[Stop before unapproved work]
    D --> L[Search/fetch remains blocked while MCP-GATE-001 is 0]
    D --> M[Paid API calls blocked until approval flag is 1]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 300
- Achievement Unlocks: MCP-SYS-005
- Title Reward: Gate Run Operator

## Completion Proof
- `F:\servers\mcp\GATE.md` decisions are reflected in the selected run lane.
- `F:\servers\mcp\LOCAL_TESTING.md` records fresh pass/fail evidence.
- `F:\servers\mcp\TASKS.md` marks completed and blocked work honestly.
- `F:\servers\mcp\CHANGELOG.md` records any setup or behavior changes.
- `F:\servers\mcp\docs\dcs\DCS_HANDOFF_PACKET.md` contains the next bounded prompt.
- No search/fetch, write tool, widget UI, public hosting, scheduler, or paid API call is added without its exact gate approval.

## Source Notes
- `F:\servers\mcp\WORKFLOW_B_MCP_PLAN.md`
- `F:\servers\mcp\GATE.md`
- `F:\servers\mcp\TASKS.md`
- `F:\servers\mcp\docs\reference\LOCAL_TESTING.md`
- `F:\servers\mcp\docs\reference\SECRET_API_SETUP.md`
- `F:\servers\mcp\docs\dcs\DCS_HANDOFF_PACKET.md`

## Notes
- Hand-authored from the MCP Workflow B plan using `$create-quest-from-workflow`.
- This quest tracks a bounded operator run, not broad MCP feature expansion.
