---
quest_id: QST-VF-CONTROLLED-CLIENT-PILOT
user: toakezg
name: "VaultForge Controlled Client Pilot Demo"
status: completed
category: system
tier: rare
xp_reward: 300
achievement_unlocks:
  - VF-BIZ-001
title_reward: "Pilot Gate Operator"
created: 2026-05-11
due:
progress_current: 5
progress_target: 5
quest_type: manual
xp4l_rule_id: vaultforge-controlled-client-pilot-demo
tags:
  - quest
  - system
  - vaultforge
  - business
  - workflow-b
  - xp4l

---
# VaultForge Controlled Client Pilot Demo

## Objective
Take VaultForge Business through one controlled client-style pilot without
mistaking a private proof for a public launch. Patch the workflow snags, shape
one demo brief, prove the prompt path with no-live checks, and stop at the
paid/API gate unless the exact pilot scope, budget, output path, and review
purpose are approved.

## Tasks
- [x] Stabilize the workflow surface ✅ 2026-05-11
  - [x] Fix the invalid root ignore glob that breaks fast search ✅ 2026-05-11
  - [x] Restore a valid root mapping for the nested XP4L lane ✅ 2026-05-11
  - [x] Remove tracked Python bytecode artifacts from the trusted workflow ✅ 2026-05-11
  - [x] Confirm root status is explainable before pilot checks ✅ 2026-05-11
- [x] Prepare the controlled pilot artifacts ✅ 2026-05-11
  - [x] Write the business pilot/demo scope note ✅ 2026-05-11
  - [x] Create one runnable prompt-bank demo note ✅ 2026-05-11
  - [x] Keep pricing, licensing, publication, and legal claims out of scope ✅ 2026-05-11
  - [x] Preserve the live generation stop condition in the brief ✅ 2026-05-11
- [x] Prove no-live business execution ✅ 2026-05-11
  - [x] Run markdown-bank WhatIf for the pilot note ✅ 2026-05-11
  - [x] Run markdown-bank DryRun for the pilot note ✅ 2026-05-11
  - [x] Verify pack-runner WhatIf remains no-log by default ✅ 2026-05-11
  - [x] Verify no business output fixtures are written by default dry-run ✅ 2026-05-11
- [x] Check engine and repo health ✅ 2026-05-11
  - [x] Run engine unit tests with `PYTHONPATH=src` ✅ 2026-05-11
  - [x] Confirm business wrapper constraint passthrough still appears in preview ✅ 2026-05-11
  - [x] Confirm `git submodule status --recursive` no longer errors ✅ 2026-05-11
  - [x] Confirm final `git status --short` only shows intended changes ✅ 2026-05-11
- [x] Stop at the hard gate or record completion proof ✅ 2026-05-11
  - [x] If live generation is requested, stop at HG-004 ✅ 2026-05-11
  - [x] Record required live scope fields before any future API call ✅ 2026-05-11
  - [x] Mark the milestone valid only for controlled private demo usage ✅ 2026-05-11
  - [x] Leave the next operator command path in the handoff ✅ 2026-05-11

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();
const doneByText = Object.fromEntries(allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const taskNodes = {
  "Stabilize the workflow surface": "STABLE",
  "Fix the invalid root ignore glob that breaks fast search": "STABLE_1",
  "Restore a valid root mapping for the nested XP4L lane": "STABLE_2",
  "Remove tracked Python bytecode artifacts from the trusted workflow": "STABLE_3",
  "Confirm root status is explainable before pilot checks": "STABLE_4",
  "Prepare the controlled pilot artifacts": "ARTIFACTS",
  "Write the business pilot/demo scope note": "ARTIFACTS_1",
  "Create one runnable prompt-bank demo note": "ARTIFACTS_2",
  "Keep pricing, licensing, publication, and legal claims out of scope": "ARTIFACTS_3",
  "Preserve the live generation stop condition in the brief": "ARTIFACTS_4",
  "Prove no-live business execution": "NOLIVE",
  "Run markdown-bank WhatIf for the pilot note": "NOLIVE_1",
  "Run markdown-bank DryRun for the pilot note": "NOLIVE_2",
  "Verify pack-runner WhatIf remains no-log by default": "NOLIVE_3",
  "Verify no business output fixtures are written by default dry-run": "NOLIVE_4",
  "Check engine and repo health": "HEALTH",
  "Run engine unit tests with `PYTHONPATH=src`": "HEALTH_1",
  "Confirm business wrapper constraint passthrough still appears in preview": "HEALTH_2",
  "Confirm `git submodule status --recursive` no longer errors": "HEALTH_3",
  "Confirm final `git status --short` only shows intended changes": "HEALTH_4",
  "Stop at the hard gate or record completion proof": "GATE",
  "If live generation is requested, stop at HG-004": "GATE_1",
  "Record required live scope fields before any future API call": "GATE_2",
  "Mark the milestone valid only for controlled private demo usage": "GATE_3",
  "Leave the next operator command path in the handoff": "GATE_4"
};
const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) if (doneByText[taskText]) doneNodes.push(nodeId);
dv.paragraph(`Task map progress: **${allTasks.filter(t => t.completed).length}/${allTasks.length}** checklist items complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    STABLE[Stabilize the workflow surface] --> STABLE_1[Fix ignore glob]
    STABLE --> STABLE_2[Restore XP4L mapping]
    STABLE --> STABLE_3[Remove pyc artifacts]
    STABLE --> STABLE_4[Check root status]
    STABLE --> ARTIFACTS[Prepare controlled pilot artifacts]
    ARTIFACTS --> ARTIFACTS_1[Write pilot scope]
    ARTIFACTS --> ARTIFACTS_2[Create prompt-bank demo note]
    ARTIFACTS --> ARTIFACTS_3[Keep launch claims out]
    ARTIFACTS --> ARTIFACTS_4[Preserve live stop condition]
    ARTIFACTS --> NOLIVE[Prove no-live business execution]
    NOLIVE --> NOLIVE_1[Markdown-bank WhatIf]
    NOLIVE --> NOLIVE_2[Markdown-bank DryRun]
    NOLIVE --> NOLIVE_3[Pack WhatIf no-log]
    NOLIVE --> NOLIVE_4[No default dry-run fixtures]
    NOLIVE --> HEALTH[Check engine and repo health]
    HEALTH --> HEALTH_1[Engine unit tests]
    HEALTH --> HEALTH_2[Constraint passthrough preview]
    HEALTH --> HEALTH_3[Submodule status works]
    HEALTH --> HEALTH_4[Final status scoped]
    HEALTH --> GATE[Stop at hard gate or record proof]
    GATE --> GATE_1[Stop at HG-004 if live requested]
    GATE --> GATE_2[Record live scope fields]
    GATE --> GATE_3[Mark controlled-demo validity]
    GATE --> GATE_4[Leave next operator path]
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Workflow Map
```dataviewjs
const topTasks = dv.current().file.tasks.where(t => !t.parent).array();
const doneByText = Object.fromEntries(topTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed]));
const stageNodes = {
  "Stabilize the workflow surface": ["A", "B", "C"],
  "Prepare the controlled pilot artifacts": ["D", "E"],
  "Prove no-live business execution": ["F", "G"],
  "Check engine and repo health": ["H", "I"],
  "Stop at the hard gate or record completion proof": ["J", "K", "L"]
};
const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) if (doneByText[taskText]) doneNodes.push(...nodes);
dv.paragraph(`Workflow progress: **${topTasks.filter(t => t.completed).length}/${topTasks.length}** task groups complete.`);
const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";
const chart = String.raw`flowchart TD
    A[Audit prior blockers] --> B[Patch repo hygiene]
    B --> C{Status explainable?}
    C -- no --> B
    C -- yes --> D[Write pilot/demo scope]
    D --> E[Create runnable prompt note]
    E --> F[WhatIf preview]
    F --> G[No-live DryRun]
    G --> H[Engine tests and wrapper checks]
    H --> I{Health stable?}
    I -- no --> B
    I -- yes --> J{Live generation requested?}
    J -- no --> K[Record controlled-demo proof]
    J -- yes --> L[Stop at HG-004]
    L --> M[Require scope, budget, output path, review purpose]
    K --> N[Ready for controlled private demo use]
    M --> N
    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;
dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Rewards
- XP: 300
- Achievement Unlocks: VF-BIZ-001
- Title Reward: Pilot Gate Operator

## Completion Proof
- `F:\vaultforge\.gitignore` no longer breaks `rg`.
- Root nested XP4L mapping no longer breaks `git submodule status --recursive`.
- Tracked Python bytecode artifacts are removed from the workflow surface.
- `F:\vaultforge\vaultforge-business\PILOT_DEMO_SCOPE_2026-05-11.md` records the private pilot/demo boundary.
- `F:\vaultforge\vaultforge-business\my-prompts-bank\pilot-demo\controlled-client-style-pilot-demo-01.md` previews and dry-runs without live generation.
- The final handoff states whether the run stopped at HG-004.

## Source Notes
- `F:\vaultforge\vaultforge-business\BUSINESS_CLIENT_READY_CRITERIA.md`
- `F:\vaultforge\vaultforge-business\BUSINESS_PAID_LAUNCH_DECISION_NOTE.md`
- `F:\vaultforge\vaultforge-business\BUSINESS_OUTPUT_REVIEW_CHECKLIST.md`
- `F:\vaultforge\HARD_GATES.md`
- `F:\vaultforge\vaultforge-business\PILOT_DEMO_SCOPE_2026-05-11.md`

## Notes
- Hand-authored from the controlled client-style pilot/demo workflow using `$create-quest-from-workflow`.
- This quest tracks a private no-live proof path and an explicit hard-gate stop, not public launch approval.
