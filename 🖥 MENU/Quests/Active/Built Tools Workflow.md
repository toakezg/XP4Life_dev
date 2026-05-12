---
quest_id: QST-MCP-BUILT-TOOLS-WORKFLOW
user: toakezg
name: "Built Tools Workflow"
status: completed
category: system
tier: epic
xp_reward: 420
achievement_unlocks:
  - MCP-SYS-006
title_reward: "Toolline Foreman"
created: 2026-05-11
due:
progress_current: 6
progress_target: 6
quest_type: manual
xp4l_rule_id: mcp-built-tools-workflow
tags:
  - quest
  - system
  - mcp
  - workflow
  - tool-building
  - xp4l

---
# Built Tools Workflow

## Objective
The tool list is no longer just a map. It is a bench of parts waiting to be fitted into the MCP server. Build the new `built-tools-workflow` so each batch starts with contracts, moves through implementation and dry proof, then stops cleanly at the GPT app live gate with the next run already loaded.

## Tasks
- [x] Forge the reusable workflow
  - [x] Read the current tool-list and Workflow B lessons
  - [x] Capture where Workflow B shined for gates, cycles, and handoff
  - [x] Capture where Workflow B lacked batch contracts and GPT proof queues
  - [x] Save `docs\reference\BUILT_TOOLS_WORKFLOW.md`
- [x] Install the callable skill
  - [x] Create `built-tools-workflow` under the Codex skills folder
  - [x] Write a concise `SKILL.md`
  - [x] Add the detailed workflow reference
  - [x] Validate the skill metadata
- [x] Prepare the batch-build entry lane
  - [x] Define the startup docs to read
  - [x] Define the bounded batch selection rule
  - [x] Define the per-tool contract matrix
  - [x] Define blocked actions and hard gates
- [x] Prove the local build loop
  - [x] Require syntax or type checks
  - [x] Require representative tool calls
  - [x] Require negative tests for path-shaped or unknown IDs
  - [x] Require server refresh when metadata changes
- [x] Lock the GPT app handoff
  - [x] Keep local-ready separate from GPT-app-live
  - [x] Require exact GPT live-pass tool names and sample arguments
  - [x] Record refresh and smoke artifacts
  - [x] Stop at the GPT app live gate when app-side proof is required
- [x] Run the next build prompt
  - [x] Invoke `$built-tools-workflow` from `F:\servers\mcp`
  - [x] Select the next bounded batch from `tools\tool-list.md`
  - [x] Build, dry test, document, and queue GPT proof
  - [x] Update this quest with completion proof

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Forge the reusable workflow": "TASK_FORGE",
  "Read the current tool-list and Workflow B lessons": "TASK_FORGE_1",
  "Capture where Workflow B shined for gates, cycles, and handoff": "TASK_FORGE_2",
  "Capture where Workflow B lacked batch contracts and GPT proof queues": "TASK_FORGE_3",
  "Save `docs\\reference\\BUILT_TOOLS_WORKFLOW.md`": "TASK_FORGE_4",
  "Install the callable skill": "TASK_SKILL",
  "Create `built-tools-workflow` under the Codex skills folder": "TASK_SKILL_1",
  "Write a concise `SKILL.md`": "TASK_SKILL_2",
  "Add the detailed workflow reference": "TASK_SKILL_3",
  "Validate the skill metadata": "TASK_SKILL_4",
  "Prepare the batch-build entry lane": "TASK_LANE",
  "Define the startup docs to read": "TASK_LANE_1",
  "Define the bounded batch selection rule": "TASK_LANE_2",
  "Define the per-tool contract matrix": "TASK_LANE_3",
  "Define blocked actions and hard gates": "TASK_LANE_4",
  "Prove the local build loop": "TASK_PROVE",
  "Require syntax or type checks": "TASK_PROVE_1",
  "Require representative tool calls": "TASK_PROVE_2",
  "Require negative tests for path-shaped or unknown IDs": "TASK_PROVE_3",
  "Require server refresh when metadata changes": "TASK_PROVE_4",
  "Lock the GPT app handoff": "TASK_GPT",
  "Keep local-ready separate from GPT-app-live": "TASK_GPT_1",
  "Require exact GPT live-pass tool names and sample arguments": "TASK_GPT_2",
  "Record refresh and smoke artifacts": "TASK_GPT_3",
  "Stop at the GPT app live gate when app-side proof is required": "TASK_GPT_4",
  "Run the next build prompt": "TASK_RUN",
  "Invoke `$built-tools-workflow` from `F:\\servers\\mcp`": "TASK_RUN_1",
  "Select the next bounded batch from `tools\\tool-list.md`": "TASK_RUN_2",
  "Build, dry test, document, and queue GPT proof": "TASK_RUN_3",
  "Update this quest with completion proof": "TASK_RUN_4"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_FORGE[Forge the reusable workflow] --> TASK_FORGE_1[Read tool-list and Workflow B lessons]
    TASK_FORGE --> TASK_FORGE_2[Capture what Workflow B did well]
    TASK_FORGE --> TASK_FORGE_3[Capture what it lacked for batches]
    TASK_FORGE --> TASK_FORGE_4[Save BUILT_TOOLS_WORKFLOW.md]
    TASK_FORGE --> TASK_SKILL[Install the callable skill]
    TASK_SKILL --> TASK_SKILL_1[Create built-tools-workflow skill]
    TASK_SKILL --> TASK_SKILL_2[Write concise SKILL.md]
    TASK_SKILL --> TASK_SKILL_3[Add detailed reference]
    TASK_SKILL --> TASK_SKILL_4[Validate metadata]
    TASK_SKILL --> TASK_LANE[Prepare the batch-build entry lane]
    TASK_LANE --> TASK_LANE_1[Define startup docs]
    TASK_LANE --> TASK_LANE_2[Define batch selection]
    TASK_LANE --> TASK_LANE_3[Define contract matrix]
    TASK_LANE --> TASK_LANE_4[Define blocked actions]
    TASK_LANE --> TASK_PROVE[Prove the local build loop]
    TASK_PROVE --> TASK_PROVE_1[Require syntax checks]
    TASK_PROVE --> TASK_PROVE_2[Require representative calls]
    TASK_PROVE --> TASK_PROVE_3[Require negative tests]
    TASK_PROVE --> TASK_PROVE_4[Require refresh on metadata changes]
    TASK_PROVE --> TASK_GPT[Lock the GPT app handoff]
    TASK_GPT --> TASK_GPT_1[Separate local-ready from GPT-live]
    TASK_GPT --> TASK_GPT_2[Name exact GPT live-pass tools]
    TASK_GPT --> TASK_GPT_3[Record artifacts]
    TASK_GPT --> TASK_GPT_4[Stop at GPT app gate]
    TASK_GPT --> TASK_RUN[Run the next build prompt]
    TASK_RUN --> TASK_RUN_1[Invoke built-tools-workflow]
    TASK_RUN --> TASK_RUN_2[Select next tool batch]
    TASK_RUN --> TASK_RUN_3[Build, test, document, queue proof]
    TASK_RUN --> TASK_RUN_4[Update quest proof]

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
  "Forge the reusable workflow": ["A", "B", "C", "D"],
  "Install the callable skill": ["E", "F"],
  "Prepare the batch-build entry lane": ["G", "H"],
  "Prove the local build loop": ["I", "J", "K", "L"],
  "Lock the GPT app handoff": ["M", "N", "O", "P"],
  "Run the next build prompt": ["Q", "R", "S", "T"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    A[Start from repo and tool list] --> B[Refresh docs, gates, dirty state]
    B --> C{Approved build lane exists?}
    C -- no --> D[Stop with gate note or safe read-only plan]
    C -- yes --> E[Select bounded tool batch]
    E --> F[Write fixed contract matrix]
    F --> G{Any hard-gated behavior?}
    G -- yes --> H[Split out or stop at hard gate]
    G -- no --> I[Implement with existing server patterns]
    I --> J[Run syntax, smoke, and direct calls]
    J --> K{Local tests pass?}
    K -- no --> L[Fix contract or implementation]
    L --> J
    K -- yes --> M[Review for broad inputs and leaks]
    M --> N{Needs tightening?}
    N -- yes --> I
    N -- no --> O[Update docs and handoff]
    O --> P[Refresh server and tunnel if metadata changed]
    P --> Q[Write GPT app live-pass queue]
    Q --> R{GPT app proof required?}
    R -- yes --> S[Stop at GPT app live gate]
    R -- no --> T[Mark batch complete and select next batch]
    T --> E

    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 420
- Achievement Unlocks: MCP-SYS-006
- Title Reward: Toolline Foreman

## Completion Proof
- `F:\servers\mcp\docs\reference\BUILT_TOOLS_WORKFLOW.md` exists and contains the reusable workflow.
- `C:\Users\natha\.codex\skills\built-tools-workflow\SKILL.md` exists and can be invoked as `$built-tools-workflow`.
- `C:\Users\natha\.codex\skills\built-tools-workflow\references\built-tools-workflow.md` contains the detailed reusable workflow.
- Skill validation passes.
- The next prompt used `$built-tools-workflow` to add and locally verify tools 71-150.
- `F:\servers\mcp\tools\tool-list.md` now lists 150 tools.
- The MCP setup server reports version `0.3.0` and 150 tools.
- Refresh artifact: `runs\refresh\20260511T120215876`.
- Smoke artifact: `runs\connector-smoke\20260511T120221310`.
- Scoped draft proof: `docs\reference\drafts\mcp-built-tools-150-contract-matrix-smoke-20260511t1202.md`.
- The remaining project gate is GPT Developer Mode live confirmation for tools 71-150.

## Source Notes
- `F:\servers\mcp\tools\tool-list.md`
- `F:\servers\mcp\WORKFLOW_B_MCP_PLAN.md`
- `F:\servers\mcp\WORKFLOW_REVIEW.md`
- `F:\servers\mcp\docs\reference\BUILT_TOOLS_WORKFLOW.md`
- `C:\Users\natha\.codex\skills\built-tools-workflow\SKILL.md`

## Notes
- Hand-authored with `$workflow-forge` and `$create-quest-from-workflow`.
- This quest is for establishing the reusable tool-building workflow, then using it in the next build prompt.
