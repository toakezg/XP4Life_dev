---
quest_id: QST-MCP-PROCEDURAL-JOB-RUNNER
user: toakezg
name: "MCP Procedural Job Runner"
status: completed
category: system
tier: rare
xp_reward: 320
achievement_unlocks:
  - MCP-SYS-005
title_reward: "Procedure Smith"
created: 2026-05-11
due:
progress_current: 5
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-procedural-job-runner
tags:
  - quest
  - system
  - mcp
  - workflow
  - development
  - xp4l

---
# MCP Procedural Job Runner

## Objective
The bridge can already read, fetch, and write scoped draft notes through ChatGPT. The next mission is to give it hands for repeatable procedural work without handing it the whole shell. Build the job runner as a disciplined forge: named jobs, previewed commands, fixed paths, visible artifacts, and only then a live run.

## Tasks
- [x] Lock the procedural contract
  - [x] Read `docs\reference\PROCEDURAL_JOB_RUNNER.md`
  - [x] Confirm the first job is `connector_smoke`
  - [x] Confirm arbitrary shell, raw `.bat` paths, and tunnel-start tools stay blocked
  - [x] Update gate notes if the scope changes
- [x] Create the job registry slice
  - [x] Define the `connector_smoke` job ID
  - [x] Record the fixed working directory
  - [x] Record allowed endpoint shapes
  - [x] Record expected artifact writes under `runs\connector-smoke`
- [x] Implement preview tools
  - [x] Add `list_approved_jobs`
  - [x] Add `preview_approved_job`
  - [x] Return exact command, cwd, timeout, expected writes, and blocked actions
  - [x] Verify no process starts during preview
- [x] Promote the first live job
  - [x] Review the preview artifact against `GATE.md`
  - [x] Implement `run_approved_job` for `connector_smoke` only
  - [x] Run one local job pass
  - [x] Record the run artifact path
- [x] Close the loop into development rhythm
  - [x] Add `read_job_run` for sanitized artifact reads
  - [x] Refresh ChatGPT Developer Mode metadata
  - [x] Run one GPT-side procedural test
  - [x] Update `TASKS.md`, `LOCAL_TESTING.md`, and `DCS_HANDOFF_PACKET.md`

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Lock the procedural contract": "TASK_CONTRACT",
  "Read `docs\\reference\\PROCEDURAL_JOB_RUNNER.md`": "TASK_CONTRACT_1",
  "Confirm the first job is `connector_smoke`": "TASK_CONTRACT_2",
  "Confirm arbitrary shell, raw `.bat` paths, and tunnel-start tools stay blocked": "TASK_CONTRACT_3",
  "Update gate notes if the scope changes": "TASK_CONTRACT_4",
  "Create the job registry slice": "TASK_REGISTRY",
  "Define the `connector_smoke` job ID": "TASK_REGISTRY_1",
  "Record the fixed working directory": "TASK_REGISTRY_2",
  "Record allowed endpoint shapes": "TASK_REGISTRY_3",
  "Record expected artifact writes under `runs\\connector-smoke`": "TASK_REGISTRY_4",
  "Implement preview tools": "TASK_PREVIEW",
  "Add `list_approved_jobs`": "TASK_PREVIEW_1",
  "Add `preview_approved_job`": "TASK_PREVIEW_2",
  "Return exact command, cwd, timeout, expected writes, and blocked actions": "TASK_PREVIEW_3",
  "Verify no process starts during preview": "TASK_PREVIEW_4",
  "Promote the first live job": "TASK_RUN",
  "Review the preview artifact against `GATE.md`": "TASK_RUN_1",
  "Implement `run_approved_job` for `connector_smoke` only": "TASK_RUN_2",
  "Run one local job pass": "TASK_RUN_3",
  "Record the run artifact path": "TASK_RUN_4",
  "Close the loop into development rhythm": "TASK_LOOP",
  "Add `read_job_run` for sanitized artifact reads": "TASK_LOOP_1",
  "Refresh ChatGPT Developer Mode metadata": "TASK_LOOP_2",
  "Run one GPT-side procedural test": "TASK_LOOP_3",
  "Update `TASKS.md`, `LOCAL_TESTING.md`, and `DCS_HANDOFF_PACKET.md`": "TASK_LOOP_4"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_CONTRACT[Lock the procedural contract] --> TASK_CONTRACT_1[Read PROCEDURAL_JOB_RUNNER.md]
    TASK_CONTRACT --> TASK_CONTRACT_2[Confirm connector_smoke first]
    TASK_CONTRACT --> TASK_CONTRACT_3[Keep shell and raw bat blocked]
    TASK_CONTRACT --> TASK_CONTRACT_4[Update gate notes if scope changes]
    TASK_CONTRACT --> TASK_REGISTRY[Create the job registry slice]
    TASK_REGISTRY --> TASK_REGISTRY_1[Define connector_smoke job ID]
    TASK_REGISTRY --> TASK_REGISTRY_2[Record fixed cwd]
    TASK_REGISTRY --> TASK_REGISTRY_3[Record allowed endpoint shapes]
    TASK_REGISTRY --> TASK_REGISTRY_4[Record expected run artifacts]
    TASK_REGISTRY --> TASK_PREVIEW[Implement preview tools]
    TASK_PREVIEW --> TASK_PREVIEW_1[Add list_approved_jobs]
    TASK_PREVIEW --> TASK_PREVIEW_2[Add preview_approved_job]
    TASK_PREVIEW --> TASK_PREVIEW_3[Return command, cwd, timeout, writes, blocks]
    TASK_PREVIEW --> TASK_PREVIEW_4[Verify preview starts no process]
    TASK_PREVIEW --> TASK_RUN[Promote the first live job]
    TASK_RUN --> TASK_RUN_1[Review preview against GATE.md]
    TASK_RUN --> TASK_RUN_2[Implement run_approved_job]
    TASK_RUN --> TASK_RUN_3[Run one local pass]
    TASK_RUN --> TASK_RUN_4[Record artifact path]
    TASK_RUN --> TASK_LOOP[Close the loop into development rhythm]
    TASK_LOOP --> TASK_LOOP_1[Add read_job_run]
    TASK_LOOP --> TASK_LOOP_2[Refresh Developer Mode metadata]
    TASK_LOOP --> TASK_LOOP_3[Run GPT-side procedural test]
    TASK_LOOP --> TASK_LOOP_4[Update task, testing, and handoff docs]

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
  "Lock the procedural contract": ["A", "B", "BLOCK"],
  "Create the job registry slice": ["C", "D"],
  "Implement preview tools": ["E", "F", "G"],
  "Promote the first live job": ["H", "I", "J"],
  "Close the loop into development rhythm": ["K", "L", "M", "N", "O"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
  A[Verified GPT Developer Mode connector] --> B[Scoped create_doc write proof]
  B --> C[Document procedural job runner contract]
  C --> D[Create approved job registry]
  D --> E[list_approved_jobs]
  E --> F[preview_approved_job]
  F --> G{Gate allows first live job?}
  G -- no --> H[Stop with preview artifact]
  G -- yes --> I[run_approved_job for connector_smoke]
  I --> J[Write run artifact under runs/connector-smoke]
  J --> K[read_job_run returns sanitized result]
  K --> L{Repeatable pass?}
  L -- no --> M[Fix registry or runner contract]
  L -- yes --> N[Promote connector_smoke to normal procedural tool]
  N --> O[Add next approved job]
  B --> BLOCK[Block arbitrary shell and raw bat launch]
  BLOCK --> C

  classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 320
- Achievement Unlocks: MCP-SYS-005
- Title Reward: Procedure Smith

## Completion Proof
- `docs\reference\PROCEDURAL_JOB_RUNNER.md` exists and names the job contract.
- `list_approved_jobs` and `preview_approved_job` are implemented without starting processes.
- Temporary local MCP checks on `http://127.0.0.1:8788/mcp` passed `list_approved_jobs`, `preview_approved_job`, and denied endpoint behavior.
- `connector_smoke` has one local live run through `run_approved_job`: `runs/job-runner/20260510T221153-b51bb9`.
- Connector smoke artifact created by that job: `runs\connector-smoke\20260511T081153581`.
- GPT Developer Mode passed `list_approved_jobs`, `preview_approved_job`, and `run_approved_job`.
- Committed live run passed: `runs/job-runner/20260510T224228-3643f0` with nested smoke artifact `runs\connector-smoke\20260511T084228686`.
- `read_job_run` passed locally and through GPT Developer Mode for committed run `20260510T224228-3643f0`, with path-shaped run ID `..\..\secret` blocked as `invalid_run_id`.
- `TASKS.md`, `LOCAL_TESTING.md`, and `DCS_HANDOFF_PACKET.md` reflect the new development phase.
- Next slice: decide the second approved job candidate before implementing or running it.

## Source Notes
- `F:\servers\mcp\docs\reference\PROCEDURAL_JOB_RUNNER.md`
- `F:\servers\mcp\PLAN.md`
- `F:\servers\mcp\TASKS.md`
- `F:\servers\mcp\GATE.md`
- `F:\servers\mcp\docs\reference\SECURITY_GATES.md`
- `F:\servers\mcp\docs\dcs\DCS_HANDOFF_PACKET.md`

## Notes
- Hand-authored with `$create-quest-from-workflow` from the procedural job runner workflow.
- The quest intentionally moves toward building and development while preserving the MCP safety boundary: named jobs over arbitrary command execution.
