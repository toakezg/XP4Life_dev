---
quest_id: QST-XP4L-BULBASOR-SIGNAL-BRIDGE
user: toakezg
name: "Bulbasor Signal Bridge"
status: active
category: system
tier: uncommon
xp_reward: 240
achievement_unlocks:
  - XP4L-SIGNAL-001
title_reward: "Signal Keeper I"
created: 2026-05-14
due:
progress_current: 0
progress_target: 5
quest_type: manual
xp4l_rule_id: bulbasor-signal-bridge
tags:
  - quest
  - system
  - xp4l
  - bulbasor
  - tapo
  - smart-home

---
# Bulbasor Signal Bridge

## Objective
Bulbasor is online: one Tapo bulb, one monitor speaker, and enough signal language to make XP4Life feel present in the room. Build the first bridge carefully: prove the bulb baseline, keep the cue palette small, wrap the commands so they do not rediscover the device every time, and only then let XP gain and event logs trigger light and sound.

## Tasks
- [ ] Lock Bulbasor baseline
  - [ ] Record discovery proof: host `192.168.1.164`, model `L530`, SSID `SG-8`, and reachable local control.
  - [ ] Confirm the current restore state before testing: `HSV 252 65 19`.
  - [ ] Keep TP-Link credentials out of notes, logs, and command examples.
- [ ] Shape cue vocabulary
  - [ ] Use `xp_gain` as the short upward sparkle cue.
  - [ ] Keep `event_logged` as a provisional tick cue until bulk logging behavior is tested.
  - [ ] Define quiet cases where sound should be skipped and only the bulb should move.
- [ ] Build manual control wrapper
  - [ ] Create a local command that connects to `192.168.1.164` without rediscovering every cue.
  - [ ] Add named commands for `xp_gain`, `event_logged`, `achievement`, `level_up`, `error`, and `restore`.
  - [ ] Restore the previous bulb state after each non-mode cue.
- [ ] Wire XP4L event sources carefully
  - [ ] Map XP gain, event logged, quest done, achievement, level up, and error events to cues.
  - [ ] Batch or rate-limit repeated `event_logged` cues so bulk logs do not hammer the monitor.
  - [ ] Keep live event writes separate from light and sound testing until explicit approval.
- [ ] Verify the signal bridge
  - [ ] Run manual `xp_gain` and `event_logged` tests with Bulbasor visible and monitor audio enabled.
  - [ ] Run one dry XP4L event replay that triggers the bridge without writing new live records.
  - [ ] Record final command examples, cue decisions, and remaining limits in this quest note.

## Task Order Map
```dataviewjs
const allTasks = dv.current().file.tasks.array();

const doneByText = Object.fromEntries(
  allTasks.map(t => [t.text.replace(/\s+/g, " ").trim(), t.completed])
);

const taskNodes = {
  "Lock Bulbasor baseline": "TASK_BASELINE",
  "Record discovery proof: host `192.168.1.164`, model `L530`, SSID `SG-8`, and reachable local control.": "TASK_BASELINE_1",
  "Confirm the current restore state before testing: `HSV 252 65 19`.": "TASK_BASELINE_2",
  "Keep TP-Link credentials out of notes, logs, and command examples.": "TASK_BASELINE_3",
  "Shape cue vocabulary": "TASK_CUES",
  "Use `xp_gain` as the short upward sparkle cue.": "TASK_CUES_1",
  "Keep `event_logged` as a provisional tick cue until bulk logging behavior is tested.": "TASK_CUES_2",
  "Define quiet cases where sound should be skipped and only the bulb should move.": "TASK_CUES_3",
  "Build manual control wrapper": "TASK_WRAPPER",
  "Create a local command that connects to `192.168.1.164` without rediscovering every cue.": "TASK_WRAPPER_1",
  "Add named commands for `xp_gain`, `event_logged`, `achievement`, `level_up`, `error`, and `restore`.": "TASK_WRAPPER_2",
  "Restore the previous bulb state after each non-mode cue.": "TASK_WRAPPER_3",
  "Wire XP4L event sources carefully": "TASK_EVENTS",
  "Map XP gain, event logged, quest done, achievement, level up, and error events to cues.": "TASK_EVENTS_1",
  "Batch or rate-limit repeated `event_logged` cues so bulk logs do not hammer the monitor.": "TASK_EVENTS_2",
  "Keep live event writes separate from light and sound testing until explicit approval.": "TASK_EVENTS_3",
  "Verify the signal bridge": "TASK_VERIFY",
  "Run manual `xp_gain` and `event_logged` tests with Bulbasor visible and monitor audio enabled.": "TASK_VERIFY_1",
  "Run one dry XP4L event replay that triggers the bridge without writing new live records.": "TASK_VERIFY_2",
  "Record final command examples, cue decisions, and remaining limits in this quest note.": "TASK_VERIFY_3"
};

const doneNodes = [];
for (const [taskText, nodeId] of Object.entries(taskNodes)) {
  if (doneByText[taskText]) doneNodes.push(nodeId);
}

const completeCount = allTasks.filter(t => t.completed).length;
dv.paragraph(`Task map progress: **${completeCount}/${allTasks.length}** checklist items complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    TASK_BASELINE[Lock Bulbasor baseline] --> TASK_BASELINE_1[Record host model network and local control]
    TASK_BASELINE --> TASK_BASELINE_2[Confirm restore HSV state]
    TASK_BASELINE --> TASK_BASELINE_3[Keep credentials out of notes]
    TASK_BASELINE --> TASK_CUES[Shape cue vocabulary]
    TASK_CUES --> TASK_CUES_1[Use xp_gain upward sparkle]
    TASK_CUES --> TASK_CUES_2[Keep event_logged provisional]
    TASK_CUES --> TASK_CUES_3[Define quiet cases]
    TASK_CUES --> TASK_WRAPPER[Build manual control wrapper]
    TASK_WRAPPER --> TASK_WRAPPER_1[Connect without repeated discovery]
    TASK_WRAPPER --> TASK_WRAPPER_2[Add named cue commands]
    TASK_WRAPPER --> TASK_WRAPPER_3[Restore previous bulb state]
    TASK_WRAPPER --> TASK_EVENTS[Wire XP4L event sources carefully]
    TASK_EVENTS --> TASK_EVENTS_1[Map XP4L event types to cues]
    TASK_EVENTS --> TASK_EVENTS_2[Batch or rate-limit event_logged]
    TASK_EVENTS --> TASK_EVENTS_3[Separate live writes from cue tests]
    TASK_EVENTS --> TASK_VERIFY[Verify the signal bridge]
    TASK_VERIFY --> TASK_VERIFY_1[Run manual cue tests]
    TASK_VERIFY --> TASK_VERIFY_2[Run dry XP4L replay]
    TASK_VERIFY --> TASK_VERIFY_3[Record commands decisions and limits]

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
  "Lock Bulbasor baseline": ["DISCOVER", "BASELINE"],
  "Shape cue vocabulary": ["PALETTE", "XPGAIN", "EVENTLOGGED"],
  "Build manual control wrapper": ["WRAPPER", "RESTORE"],
  "Wire XP4L event sources carefully": ["EVENTS", "RATE_LIMIT", "LIVE_GATE"],
  "Verify the signal bridge": ["VERIFY", "DONE"]
};

const doneNodes = [];
for (const [taskText, nodes] of Object.entries(stageNodes)) {
  if (doneByText[taskText]) doneNodes.push(...nodes);
}

const completeCount = topTasks.filter(t => t.completed).length;
dv.paragraph(`Workflow progress: **${completeCount}/${topTasks.length}** task groups complete.`);

const classLine = doneNodes.length ? `    class ${doneNodes.join(",")} done;` : "";

const chart = String.raw`flowchart TD
    DISCOVER[Bulbasor discovered on SG-8] --> BASELINE[Baseline host and restore HSV recorded]
    BASELINE --> PALETTE[Small cue palette]
    PALETTE --> XPGAIN[xp_gain: quick green sparkle]
    PALETTE --> EVENTLOGGED[event_logged: provisional tick]
    XPGAIN --> WRAPPER[Local Bulbasor command wrapper]
    EVENTLOGGED --> WRAPPER
    WRAPPER --> RESTORE[Restore previous state after cues]
    RESTORE --> EVENTS[Map XP4L events to cues]
    EVENTS --> RATE_LIMIT[Batch or rate-limit noisy events]
    RATE_LIMIT --> LIVE_GATE{Explicit live/write approval?}
    LIVE_GATE -->|No| VERIFY[Dry replay and manual tests only]
    LIVE_GATE -->|Yes| LIVE[Attach to live XP4L event flow]
    LIVE --> VERIFY
    VERIFY --> DONE[Signal bridge ready]

    classDef done fill:#e6ffed,stroke:#2ea043,color:#116329,stroke-width:2px;
${classLine}`;

dv.paragraph("```mermaid\n" + chart + "\n```");
```

## Cue Drafts
### xp_gain
This is the preferred small XP cue: quick green flash, two very short rising tones, then restore.

```powershell
&{
  kasa --host 192.168.1.164 hsv 120 100 45
  [console]::beep(1560,11)
  [console]::beep(1680,11)
  kasa --host 192.168.1.164 hsv 252 65 19
}
```

### event_logged
This cue is useful for an event packet or confirmation tick, but it may be too much when several events are logged together. Treat it as provisional until batching/rate limiting is tested.

```powershell
& {
  kasa --host 192.168.1.164 hsv 120 100 45
  [console]::beep(880,22)

  kasa --host 192.168.1.164 hsv 252 65 19
  [console]::beep(1175,22)

  kasa --host 192.168.1.164 hsv 120 100 45
  [console]::beep(1560,11)
  [console]::beep(1560,11)
  kasa --host 192.168.1.164 hsv 252 65 19
}
```

## Rewards
- XP: 240
- Achievement Unlocks: XP4L-SIGNAL-001
- Title Reward: Signal Keeper I

## Completion Proof
- Bulbasor can be controlled locally by host without a fresh discovery delay for every cue.
- `xp_gain` and `event_logged` are tested manually with visible bulb response and audible monitor output.
- No secrets are printed or stored in the quest note.
- Bulk event behavior is rate-limited or deliberately silent.
- A dry XP4L event replay triggers the bridge without writing new live records.

## Source Notes
- Current chat discovery output: Bulbasor / Tapo L530 at `192.168.1.164` on `SG-8`.
- Manual test snippets from the Bulbasor cue discussion.
- XP4L event/progression flow as the intended trigger source after manual cue testing.

## Notes
- Hand-authored from the Bulbasor setup workflow.
- Keep `event_logged` softer or batched before it becomes a default cue.
- The first implementation should stay local and small before adding any home automation hub.
