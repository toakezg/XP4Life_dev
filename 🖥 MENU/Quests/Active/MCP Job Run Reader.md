---
quest_id: QST-MCP-JOB-RUN-READER
user: toakezg
name: "MCP Job Run Reader"
status: completed
category: system
tier: rare
xp_reward: 300
achievement_unlocks:
  - MCP-SYS-006
title_reward: "Run Archivist"
created: 2026-05-11
due:
progress_current: 5
progress_target: 5
quest_type: manual
xp4l_rule_id: mcp-job-run-reader
tags:
  - quest
  - system
  - mcp
  - workflow
  - development
  - xp4l

---
# MCP Job Run Reader

## Objective
The bridge has learned to run one approved job without opening the shell. Now give it a lantern for the artifacts it creates. Build `read_job_run` as a bounded reader: known run IDs only, job-runner artifacts only, short sanitized previews, and no second runnable job until the proof stays clean.

## Tasks
- [x] Confirm the live-run baseline
  - [x] Read `docs\reference\PROCEDURAL_JOB_RUNNER.md`
  - [x] Read `docs\reference\TOOL_SURFACE.md`
  - [x] Confirm `run_approved_job` passed for `connector_smoke`
  - [x] Confirm the committed run artifact is `runs/job-runner/20260510T224228-3643f0`
- [x] Define the artifact reader boundary
  - [x] Allow only known `runId` values under `runs\job-runner`
  - [x] Reject raw filesystem paths and path traversal
  - [x] Return `summary.json` plus short stdout and stderr previews
  - [x] Keep credential, environment, tunnel, delete, rename, overwrite, paid API, and scheduler actions blocked
- [x] Implement `read_job_run`
  - [x] Add the tool schema to the active MCP server
  - [x] Read only the approved artifact files for a known run
  - [x] Sanitize or truncate stdout and stderr previews
  - [x] Preserve connector-compatible text and structured content
- [x] Verify the reader locally and through GPT
  - [x] Run local MCP checks for a valid run ID
  - [x] Run local denial checks for path-shaped and unknown run IDs
  - [x] Refresh ChatGPT Developer Mode metadata
  - [x] Ask GPT to read the committed job run artifact
- [x] Promote the next build direction
  - [x] Update `TASKS.md`, `LOCAL_TESTING.md`, and `TOOL_SURFACE.md`
  - [x] Update `DCS_HANDOFF_PACKET.md` with the next bounded prompt
  - [x] Decide the next approved job candidate without implementing it yet
  - [x] Keep arbitrary launcher `.bat` tools blocked

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Confirm the live-run baseline": "TASK_BASE",
  "Read `docs\\reference\\PROCEDURAL_JOB_RUNNER.md`": "TASK_BASE_1",
  "Read `docs\\reference\\TOOL_SURFACE.md`": "TASK_BASE_2",
  "Confirm `run_approved_job` passed for `connector_smoke`": "TASK_BASE_3",
  "Confirm the committed run artifact is `runs/job-runner/20260510T224228-3643f0`": "TASK_BASE_4",
  "Define the artifact reader boundary": "TASK_BOUNDARY",
  "Allow only known `runId` values under `runs\\job-runner`": "TASK_BOUNDARY_1",
  "Reject raw filesystem paths and path traversal": "TASK_BOUNDARY_2",
  "Return `summary.json` plus short stdout and stderr previews": "TASK_BOUNDARY_3",
  "Keep credential, environment, tunnel, delete, rename, overwrite, paid API, and scheduler actions blocked": "TASK_BOUNDARY_4",
  "Implement `read_job_run`": "TASK_IMPLEMENT",
  "Add the tool schema to the active MCP server": "TASK_IMPLEMENT_1",
  "Read only the approved artifact files for a known run": "TASK_IMPLEMENT_2",
  "Sanitize or truncate stdout and stderr previews": "TASK_IMPLEMENT_3",
  "Preserve connector-compatible text and structured content": "TASK_IMPLEMENT_4",
  "Verify the reader locally and through GPT": "TASK_VERIFY",
  "Run local MCP checks for a valid run ID": "TASK_VERIFY_1",
  "Run local denial checks for path-shaped and unknown run IDs": "TASK_VERIFY_2",
  "Refresh ChatGPT Developer Mode metadata": "TASK_VERIFY_3",
  "Ask GPT to read the committed job run artifact": "TASK_VERIFY_4",
  "Promote the next build direction": "TASK_PROMOTE",
  "Update `TASKS.md`, `LOCAL_TESTING.md`, and `TOOL_SURFACE.md`": "TASK_PROMOTE_1",
  "Update `DCS_HANDOFF_PACKET.md` with the next bounded prompt": "TASK_PROMOTE_2",
  "Decide the next approved job candidate without implementing it yet": "TASK_PROMOTE_3",
  "Keep arbitrary launcher `.bat` tools blocked": "TASK_PROMOTE_4"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_BASE[Confirm the live-run baseline] --> TASK_BASE_1[Read PROCEDURAL_JOB_RUNNER.md]
    TASK_BASE --> TASK_BASE_2[Read TOOL_SURFACE.md]
    TASK_BASE --> TASK_BASE_3[Confirm run_approved_job pass]
    TASK_BASE --> TASK_BASE_4[Confirm committed run artifact]
    TASK_BASE --> TASK_BOUNDARY[Define the artifact reader boundary]
    TASK_BOUNDARY --> TASK_BOUNDARY_1[Known run IDs only]
    TASK_BOUNDARY --> TASK_BOUNDARY_2[Reject paths and traversal]
    TASK_BOUNDARY --> TASK_BOUNDARY_3[Return summary and previews]
    TASK_BOUNDARY --> TASK_BOUNDARY_4[Keep blocked actions blocked]
    TASK_BOUNDARY --> TASK_IMPLEMENT[Implement read_job_run]
    TASK_IMPLEMENT --> TASK_IMPLEMENT_1[Add tool schema]
    TASK_IMPLEMENT --> TASK_IMPLEMENT_2[Read approved artifact files]
    TASK_IMPLEMENT --> TASK_IMPLEMENT_3[Sanitize previews]
    TASK_IMPLEMENT --> TASK_IMPLEMENT_4[Preserve connector compatibility]
    TASK_IMPLEMENT --> TASK_VERIFY[Verify locally and through GPT]
    TASK_VERIFY --> TASK_VERIFY_1[Valid run ID check]
    TASK_VERIFY --> TASK_VERIFY_2[Denied run ID checks]
    TASK_VERIFY --> TASK_VERIFY_3[Refresh Developer Mode metadata]
    TASK_VERIFY --> TASK_VERIFY_4[GPT reads committed run artifact]
    TASK_VERIFY --> TASK_PROMOTE[Promote next build direction]
    TASK_PROMOTE --> TASK_PROMOTE_1[Update task and tool docs]
    TASK_PROMOTE --> TASK_PROMOTE_2[Update DCS handoff]
    TASK_PROMOTE --> TASK_PROMOTE_3[Choose next job candidate]
    TASK_PROMOTE --> TASK_PROMOTE_4[Keep raw bat launch blocked]

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
  "Confirm the live-run baseline": ["A", "B", "C"],
  "Define the artifact reader boundary": ["D", "E", "F"],
  "Implement `read_job_run`": ["G", "H"],
  "Verify the reader locally and through GPT": ["I", "J", "K"],
  "Promote the next build direction": ["L", "M", "N"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
  A[Committed live approved-job run] --> B[Job artifact exists under runs/job-runner]
  B --> C[Nested connector smoke passed]
  C --> D[Specify read_job_run boundary]
  D --> E[Known run IDs only]
  D --> F[Block paths, secrets, shell, and schedulers]
  E --> G[Implement read_job_run]
  F --> G
  G --> H[Return summary and sanitized previews]
  H --> I[Local valid run check]
  H --> J[Local denial checks]
  I --> K[GPT Developer Mode artifact read]
  J --> K
  K --> L{Repeatable reader pass?}
  L -- no --> M[Fix reader boundary or sanitization]
  L -- yes --> N[Choose next approved job candidate]
  N --> O[Stop before implementing second runnable job]

  classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 300
- Achievement Unlocks: MCP-SYS-006
- Title Reward: Run Archivist

## Completion Proof
- `read_job_run` is listed in the MCP tool surface.
- Local valid-run and denial checks pass.
- Local smoke evidence: `runs\connector-smoke\20260511T093852879`.
- Refresh evidence: `runs\refresh\20260511T093846335`.
- GPT Developer Mode proof: `20260510T224228-3643f0` returned found true, blocked false, `connector_smoke`, ok true, exit code 0; `..\..\secret` returned `invalid_run_id`.
- Next approved jobs selected and locally proved: `auth_env_check` (`20260510T235035-30caec`), `openai_env_check` (`20260510T235036-817d27`), and `xp4l_watch_once_dry` (`20260510T235036-a220b0`).
- GPT Developer Mode confirmed the expanded fixed jobs: `connector_smoke` (`20260511T000034-9b52a5`), `auth_env_check` (`20260511T000044-9a542f`), `openai_env_check` (`20260511T000056-2c2f2e`), and `xp4l_watch_once_dry` (`20260511T000106-320777`).
- Next procedural compatibility tool selected and proved locally and through GPT: `list_job_runs`.
- GPT `list_job_runs` proof: limit 10 returned 10 recent records without stdout/stderr; `xp4l_watch_once_dry` filter returned three ok runs; `not_a_job` was blocked with `unknown_job_id`.

## Source Notes
- `F:\servers\mcp\docs\reference\PROCEDURAL_JOB_RUNNER.md`
- `F:\servers\mcp\docs\reference\TOOL_SURFACE.md`
- `F:\servers\mcp\docs\reference\LOCAL_TESTING.md`
- `F:\servers\mcp\TASKS.md`
- `F:\servers\mcp\docs\dcs\DCS_HANDOFF_PACKET.md`

## Notes
- Hand-authored with `$create-quest-from-workflow` from the MCP procedural job runner graph.
- This quest is the next tool-building slice. It intentionally stops before adding a second live job.
