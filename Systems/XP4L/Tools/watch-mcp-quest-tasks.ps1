param(
    [string]$McpRoot = "F:\servers\mcp",
    [string]$XP4LifeRoot = "F:\XP4Life",
    [int]$IntervalSeconds = 20,
    [switch]$Once
)

$ErrorActionPreference = "Stop"

$activeQuestDir = Join-Path $XP4LifeRoot "🖥 MENU\Quests\Active"
$stateDir = Join-Path $XP4LifeRoot "Systems\XP4L\State"
$logPath = Join-Path $stateDir "mcp-quest-watch.log"

New-Item -ItemType Directory -Force $stateDir | Out-Null

function Write-WatchLog {
    param([string]$Message)
    $stamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"
    Add-Content -LiteralPath $logPath -Value "[$stamp] $Message"
}

function Read-TextSafe {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        return ""
    }
    return Get-Content -Raw -LiteralPath $Path
}

function Test-FileText {
    param(
        [string]$Path,
        [string]$Pattern
    )
    $text = Read-TextSafe $Path
    return ($text -match $Pattern)
}

function Set-YamlValue {
    param(
        [string]$Text,
        [string]$Key,
        [string]$Value
    )
    $pattern = "(?m)^$([regex]::Escape($Key)):\s*.*$"
    if ($Text -match $pattern) {
        return [regex]::Replace($Text, $pattern, "${Key}: $Value", 1)
    }
    return $Text
}

function Set-TaskState {
    param(
        [string]$Text,
        [string]$Label,
        [bool]$Done
    )
    $escaped = [regex]::Escape($Label)
    $pattern = "(?m)^(\s*-\s*)\[[ xX]\](\s*$escaped\s*)$"
    $box = if ($Done) { "[x]" } else { "[ ]" }
    return [regex]::Replace($Text, $pattern, {
        param($match)
        return "$($match.Groups[1].Value)$box$($match.Groups[2].Value)"
    })
}

function Update-QuestProgress {
    param([string]$Text)
    $topTasks = [regex]::Matches($Text, "(?m)^- \[[ xX]\] ")
    $doneTasks = [regex]::Matches($Text, "(?m)^- \[[xX]\] ")
    $target = $topTasks.Count
    $current = $doneTasks.Count

    if ($target -gt 0) {
        $Text = Set-YamlValue $Text "progress_current" $current
        $Text = Set-YamlValue $Text "progress_target" $target
        if ($current -eq $target) {
            $Text = Set-YamlValue $Text "status" "completed"
            if ($Text -notmatch "(?m)^completed_on:") {
                $Text = [regex]::Replace($Text, "(?m)^created:.*$", "`$0`r`ncompleted_on: $(Get-Date -Format yyyy-MM-dd)", 1)
            }
        } else {
            $Text = Set-YamlValue $Text "status" "active"
            $Text = [regex]::Replace($Text, "(?m)^completed_on:.*\r?\n?", "", 1)
        }
    }

    return $Text
}

function Save-QuestIfChanged {
    param(
        [string]$Path,
        [string]$Text
    )
    $old = Read-TextSafe $Path
    if ($Text -ne $old) {
        Set-Content -LiteralPath $Path -Value $Text -NoNewline -Encoding utf8
        return $true
    }
    return $false
}

function Get-McpEvidence {
    $docsRef = Join-Path $McpRoot "docs\reference"
    $docsDcs = Join-Path $McpRoot "docs\dcs"
    $setupNotes = Join-Path $docsRef "SETUP_NOTES.md"
    $toolSurface = Join-Path $docsRef "TOOL_SURFACE.md"
    $securityGates = Join-Path $docsRef "SECURITY_GATES.md"
    $localTesting = Join-Path $docsRef "LOCAL_TESTING.md"
    $plan = Join-Path $docsRef "PLAN.md"
    $diagrams = Join-Path $docsRef "DIAGRAMS.md"
    $mcpSetup = Join-Path $docsDcs "mcp-setup.md"
    $handoff = Join-Path $docsDcs "DCS_HANDOFF_PACKET.md"
    $runBrief = Join-Path $docsDcs "RUN_BRIEF.md"
    $reflection = Join-Path $docsDcs "4-reflection\MCP_WORKFLOW_READINESS_REVIEW.md"
    $operation = Join-Path $docsDcs "3-operations\MCP_LOCAL_RUNTIME_OPERATION.md"
    $serverJs = Join-Path $McpRoot "servers\active\mcp-setup-server\server.js"
    $packageJson = Join-Path $McpRoot "servers\active\mcp-setup-server\package.json"
    $gate = Join-Path $McpRoot "GATE.md"
    $workflowPlan = Join-Path $McpRoot "WORKFLOW_B_MCP_PLAN.md"
    $devModePacket = Join-Path $docsRef "CHATGPT_DEVELOPER_MODE_TEST_PACKET.md"

    $localText = Read-TextSafe $localTesting
    $toolText = Read-TextSafe $toolSurface
    $securityText = Read-TextSafe $securityGates
    $handoffText = Read-TextSafe $handoff
    $runBriefText = Read-TextSafe $runBrief
    $serverText = Read-TextSafe $serverJs
    $allDcsText = ($handoffText + "`n" + $runBriefText + "`n" + (Read-TextSafe $workflowPlan) + "`n" + (Read-TextSafe $reflection) + "`n" + (Read-TextSafe $mcpSetup))

    $statusImplemented = ($serverText -match "status") -and ($localText -match "status")
    $listSourcesImplemented = ($serverText -match "list_sources") -and ($localText -match "list_sources")
    $searchImplemented = ($serverText -match "search") -and ($localText -match "search") -and ($localText -notmatch 'If `search` exists')
    $fetchImplemented = ($serverText -match "fetch") -and ($localText -match "fetch") -and ($localText -notmatch 'If `search` exists')
    $localPassed = $localText -match '/mcp` endpoint: passed raw MCP initialize, list, and tool calls'
    $inspectorPassed = ($localText -match "Printed expected tools: status, list_sources") -and ($localText -match "Printed expected status structuredContent")
    $tunnelRun = ($localText -match "Tunnel status:") -and ($localText -notmatch '(?is)Tunnel status:\s*```text\s*Not run\.')
    $gate003TunnelBlocked = $localText -match "Gate 003 Tunnel Refresh Blocker"
    $gate003TunnelHealthy = ($localText -match "Gate 003 Developer Mode.*passed|ChatGPT Developer Mode.*connected") -and (-not $gate003TunnelBlocked)
    $chatGptConnected = ($localText -match "ChatGPT Developer Mode status:") -and ($localText -notmatch '(?is)ChatGPT Developer Mode status:\s*```text\s*Not connected')
    $budget30 = $allDcsText -match '--budget-time\s+30m|--budget-time\s+30min'
    $budget90 = $allDcsText -match '--budget-time\s+90m|--budget-time\s+90min'

    return [pscustomobject]@{
        WorkspaceExists = Test-Path -LiteralPath $McpRoot
        DocsReferenceExists = Test-Path -LiteralPath $docsRef
        DocsDcsExists = Test-Path -LiteralPath $docsDcs
        BaseDocsExist = (Test-Path -LiteralPath $plan) -and (Test-Path -LiteralPath $diagrams) -and (Test-Path -LiteralPath $mcpSetup)
        SetupNotesExists = Test-Path -LiteralPath $setupNotes
        ToolSurfaceExists = Test-Path -LiteralPath $toolSurface
        SecurityGatesExists = Test-Path -LiteralPath $securityGates
        LocalTestingExists = Test-Path -LiteralPath $localTesting
        RuntimeGated = (Test-Path -LiteralPath $gate) -or ($securityText -match "DCS-3.*allowed for the smallest local runtime")
        NextPromptExists = $handoffText -match "Next Bounded Prompt|Use the MCP Workflow B plan"
        ToolOnlyChosen = $toolText -match 'Recommended first archetype:\s*`tool-only`'
        WidgetRejected = $toolText -match "Do not build a widget app yet"
        StatusImplemented = $statusImplemented
        ListSourcesImplemented = $listSourcesImplemented
        SearchFetchImplemented = $searchImplemented -and $fetchImplemented
        DryRunFirstRecorded = ($toolText + "`n" + $securityText) -match "dry-run-first|dry-run mode|dry-run preview"
        SafetyReadOnlyRecorded = $securityText -match "readOnlyHint"
        SafetyDestructiveRecorded = $securityText -match "destructiveHint"
        SafetyPathsRecorded = ($toolText + "`n" + $securityText) -match "docs\\reference|docs\\dcs|local paths"
        SafetySecretsRecorded = $securityText -match "Secrets must never be returned|must never be exposed"
        PromptSetRecorded = $localText -match "direct, follow-up, and negative prompts|Direct Prompt|Follow-Up Prompt|Negative Prompt"
        ServerExists = (Test-Path -LiteralPath $serverJs) -and (Test-Path -LiteralPath $packageJson)
        KnownPortRecorded = ($localText + "`n" + $serverText) -match "8787|known localhost port"
        HealthChecked = $localText -match "health route passes|health route.*passed|Health"
        McpChecked = $localPassed
        LocalOutputRecorded = $localText -match "Raw MCP|command output|tools/call"
        InspectorRun = $localText -match "MCP Inspector"
        InspectorListed = $inspectorPassed
        SafeToolCalled = $localText -match "tools/call status|status structuredContent|tools/call list_sources"
        FailureRecorded = $localText -match "Windows Node/libuv assertion|schema|transport failures"
        TunnelRun = $tunnelRun
        DevModePacketExists = Test-Path -LiteralPath $devModePacket
        Gate003TunnelBlocked = $gate003TunnelBlocked
        Gate003TunnelHealthy = $gate003TunnelHealthy
        ChatGptConnected = $chatGptConnected
        DcsBaseExists = Test-Path -LiteralPath $mcpSetup
        ExpandTargetRecorded = $allDcsText -match '--expand 4\.3\.2'
        HigherLayersGated = ($allDcsText -match "DCS-5") -and ($allDcsText -match "DCS-6") -and ($allDcsText -match "DCS-7") -and ($allDcsText -match "blocked|gated|skipped")
        HandoffExists = Test-Path -LiteralPath $handoff
        SourceEvidenceRecorded = $handoffText -match "Source Evidence|source evidence|docs\\reference\\PLAN.md"
        LayerStatusesRecorded = $handoffText -match "Layer Status|DCS-0|DCS-1|DCS-4"
        Cycle1Recorded = $allDcsText -match 'Cycle 1|--cycle\s+1'
        Cycle2Recorded = $allDcsText -match 'Cycle 2|--cycle\s+2'
        HandoffBeforeCycleRecorded = $allDcsText -match "handoff packet before cycling|Require a handoff packet"
        StopOnGateFailRecorded = $allDcsText -match "failed layer gate|Stop condition|Stop when a layer gate fails"
        Budget30Recorded = $budget30
        Budget90Recorded = $budget90
        CleanStopRecorded = $allDcsText -match "clean stop|stop with clean status|Current mode:"
        PartialVerificationRecorded = $allDcsText -match "partial verification|Verify each cycle|verification"
        WorkflowNoteExists = Test-Path -LiteralPath (Join-Path $docsDcs "2-expansion\LOCAL_MCP_BRIDGE_WORKFLOW.md")
        OperationTiedToChecks = (Test-Path -LiteralPath $operation) -and ($handoffText -match "DCS-3 local runtime operation completed")
        ReflectionExists = Test-Path -LiteralPath $reflection
        WorkflowPromptExists = $handoffText -match "Workflow B plan|workflow-building prompt|Next Bounded Prompt"
    }
}

function Update-BridgeQuest {
    param($Evidence)
    $path = Join-Path $activeQuestDir "MCP Bridge Groundwork.md"
    $text = Read-TextSafe $path
    if (-not $text) { return $false }

    $anchorDone = $Evidence.WorkspaceExists -and $Evidence.DocsReferenceExists -and $Evidence.DocsDcsExists -and $Evidence.BaseDocsExist
    $notesDone = $Evidence.SetupNotesExists -and $Evidence.ToolSurfaceExists -and $Evidence.SecurityGatesExists -and $Evidence.LocalTestingExists
    $runtimeGatedDone = $Evidence.RuntimeGated
    $promptDone = $Evidence.NextPromptExists

    $text = Set-TaskState $text "Confirm the workspace anchor" $anchorDone
    $text = Set-TaskState $text 'Verify `F:\servers\mcp` exists' $Evidence.WorkspaceExists
    $text = Set-TaskState $text 'Verify `docs\reference` and `docs\dcs` are present' ($Evidence.DocsReferenceExists -and $Evidence.DocsDcsExists)
    $text = Set-TaskState $text 'Re-read `PLAN.md`, `DIAGRAMS.md`, and `mcp-setup.md`' $Evidence.BaseDocsExist
    $text = Set-TaskState $text "Create the next reference notes" $notesDone
    $text = Set-TaskState $text 'Add `SETUP_NOTES.md`' $Evidence.SetupNotesExists
    $text = Set-TaskState $text 'Add `TOOL_SURFACE.md`' $Evidence.ToolSurfaceExists
    $text = Set-TaskState $text 'Add `SECURITY_GATES.md`' $Evidence.SecurityGatesExists
    $text = Set-TaskState $text 'Add `LOCAL_TESTING.md`' $Evidence.LocalTestingExists
    $text = Set-TaskState $text "Keep runtime work gated" $runtimeGatedDone
    $text = Set-TaskState $text "Confirm no runtime server code is required for this quest" $runtimeGatedDone
    $text = Set-TaskState $text "List the folders to create later only when needed" $runtimeGatedDone
    $text = Set-TaskState $text "Record which docs are planning-only" $runtimeGatedDone
    $text = Set-TaskState $text "Write the next bounded prompt" $promptDone
    $text = Set-TaskState $text "Name the smallest follow-up task" $promptDone
    $text = Set-TaskState $text "Include the allowed write paths" $promptDone
    $text = Set-TaskState $text "Include the stop condition" $promptDone
    $text = Update-QuestProgress $text
    return Save-QuestIfChanged $path $text
}

function Update-ToolSurfaceQuest {
    param($Evidence)
    $path = Join-Path $activeQuestDir "MCP Tool Surface Gate.md"
    $text = Read-TextSafe $path
    if (-not $text) { return $false }

    $archetypeDone = $Evidence.ToolOnlyChosen -and $Evidence.WidgetRejected
    $candidateDone = $Evidence.StatusImplemented -and $Evidence.ListSourcesImplemented -and $Evidence.SearchFetchImplemented -and $Evidence.DryRunFirstRecorded
    $safetyDone = $Evidence.SafetyReadOnlyRecorded -and $Evidence.SafetyDestructiveRecorded -and $Evidence.SafetyPathsRecorded -and $Evidence.SafetySecretsRecorded
    $verifyDone = $Evidence.PromptSetRecorded

    $text = Set-TaskState $text "Pick the first archetype" $archetypeDone
    $text = Set-TaskState $text 'Decide `tool-only` or `data-only`' $Evidence.ToolOnlyChosen
    $text = Set-TaskState $text "Reject widget UI unless a clear need appears" $Evidence.WidgetRejected
    $text = Set-TaskState $text "Record why this archetype fits the first test" $Evidence.ToolOnlyChosen
    $text = Set-TaskState $text "Define the candidate tools" $candidateDone
    $text = Set-TaskState $text 'Add `status`' $Evidence.StatusImplemented
    $text = Set-TaskState $text 'Add `list_sources`' $Evidence.ListSourcesImplemented
    $text = Set-TaskState $text 'Add `search` and `fetch` only if source docs are indexed' $Evidence.SearchFetchImplemented
    $text = Set-TaskState $text "Keep any action as dry-run-first" $Evidence.DryRunFirstRecorded
    $text = Set-TaskState $text "Write safety gates" $safetyDone
    $text = Set-TaskState $text "Mark every tool read-only or not read-only" $Evidence.SafetyReadOnlyRecorded
    $text = Set-TaskState $text "Mark destructive and open-world behavior honestly" $Evidence.SafetyDestructiveRecorded
    $text = Set-TaskState $text "Define what local paths may be read" $Evidence.SafetyPathsRecorded
    $text = Set-TaskState $text "Define what must never be exposed" $Evidence.SafetySecretsRecorded
    $text = Set-TaskState $text "Prepare verification prompts" $verifyDone
    $text = Set-TaskState $text "Add one direct prompt" $verifyDone
    $text = Set-TaskState $text "Add one follow-up prompt" $verifyDone
    $text = Set-TaskState $text "Add one negative prompt" $verifyDone
    $text = Set-TaskState $text "Add expected pass/fail behavior" $verifyDone
    $text = Update-QuestProgress $text
    return Save-QuestIfChanged $path $text
}

function Update-LocalConnectionQuest {
    param($Evidence)
    $path = Join-Path $activeQuestDir "MCP Local Connection Trial.md"
    $text = Read-TextSafe $path
    if (-not $text) { return $false }

    $prepareDone = $Evidence.ServerExists -and $Evidence.StatusImplemented -and $Evidence.ListSourcesImplemented -and $Evidence.KnownPortRecorded
    $localDone = $Evidence.HealthChecked -and $Evidence.McpChecked -and $Evidence.LocalOutputRecorded
    $inspectDone = $Evidence.InspectorRun -and $Evidence.InspectorListed -and $Evidence.SafeToolCalled -and $Evidence.FailureRecorded

    $text = Set-TaskState $text "Prepare the local server" $prepareDone
    $text = Set-TaskState $text "Create or adapt the smallest MCP server" $Evidence.ServerExists
    $text = Set-TaskState $text "Keep the first tool read-only or dry-run-first" ($Evidence.StatusImplemented -and $Evidence.ListSourcesImplemented)
    $text = Set-TaskState $text "Start the server on a known localhost port" $Evidence.KnownPortRecorded
    $text = Set-TaskState $text "Verify localhost" $localDone
    $text = Set-TaskState $text "Check the health route" $Evidence.HealthChecked
    $text = Set-TaskState $text 'Check the `/mcp` endpoint' $Evidence.McpChecked
    $text = Set-TaskState $text 'Record command output in `LOCAL_TESTING.md`' $Evidence.LocalOutputRecorded
    $text = Set-TaskState $text "Inspect the MCP surface" $inspectDone
    $text = Set-TaskState $text "Run MCP Inspector" $Evidence.InspectorRun
    $text = Set-TaskState $text "Confirm tool listing" $Evidence.InspectorListed
    $text = Set-TaskState $text "Call the first tool with a safe input" $Evidence.SafeToolCalled
    $text = Set-TaskState $text "Record any schema or transport failures" $Evidence.FailureRecorded
    $text = Set-TaskState $text "Open the HTTPS tunnel" $Evidence.TunnelRun
    $text = Set-TaskState $text "Start ngrok or Cloudflare Tunnel" $Evidence.TunnelRun
    $text = Set-TaskState $text "Confirm the public URL reaches only the intended endpoint" $Evidence.TunnelRun
    $text = Set-TaskState $text "Record the temporary URL without secrets" $Evidence.TunnelRun
    $text = Set-TaskState $text "Rerun Gate 009 live connector smoke" $Evidence.TunnelRun
    $text = Set-TaskState $text "Replace the stale temporary tunnel" $Evidence.TunnelRun
    $text = Set-TaskState $text "Verify public health and MCP initialize" $Evidence.TunnelRun
    $text = Set-TaskState $text 'Verify `tools/list`, `status`, and `list_sources`' $Evidence.TunnelRun
    $text = Set-TaskState $text 'Record the run under `runs\live-connection`' $Evidence.TunnelRun
    $text = Set-TaskState $text "Prepare the ChatGPT Developer Mode packet" $Evidence.DevModePacketExists
    $text = Set-TaskState $text 'Record the approved `status` prompt' $Evidence.DevModePacketExists
    $text = Set-TaskState $text 'Record the approved `list_sources` prompt' $Evidence.DevModePacketExists
    $text = Set-TaskState $text 'Record blocked `search`, secret-read, and write-action prompts' $Evidence.DevModePacketExists
    $text = Set-TaskState $text "Retry a healthy Gate 003 tunnel" $Evidence.Gate003TunnelHealthy
    $text = Set-TaskState $text "Start a fresh temporary HTTPS tunnel" $Evidence.Gate003TunnelHealthy
    $text = Set-TaskState $text 'Verify public health and `/mcp` initialize' $Evidence.Gate003TunnelHealthy
    $text = Set-TaskState $text "Stop if the tunnel returns 503, 408, or timeout" $Evidence.Gate003TunnelBlocked
    $text = Set-TaskState $text "Connect ChatGPT Developer Mode" $Evidence.ChatGptConnected
    $text = Set-TaskState $text 'Add the HTTPS `/mcp` URL' $Evidence.ChatGptConnected
    $text = Set-TaskState $text "Refresh after metadata changes" $Evidence.ChatGptConnected
    $text = Set-TaskState $text "Run direct, follow-up, and negative prompts" $Evidence.ChatGptConnected
    $text = Set-TaskState $text "Record pass/fail results" $Evidence.ChatGptConnected
    $text = Update-QuestProgress $text
    return Save-QuestIfChanged $path $text
}

function Update-DcsQuest {
    param($Evidence)
    $path = Join-Path $activeQuestDir "MCP DCS Workflow Runway.md"
    $text = Read-TextSafe $path
    if (-not $text) { return $false }

    $baseDone = $Evidence.DcsBaseExists -and $Evidence.ExpandTargetRecorded -and $Evidence.HigherLayersGated
    $handoffDone = $Evidence.HandoffExists -and $Evidence.SourceEvidenceRecorded -and $Evidence.LayerStatusesRecorded -and $Evidence.NextPromptExists
    $cycleDone = $Evidence.Cycle1Recorded -and $Evidence.Cycle2Recorded -and $Evidence.HandoffBeforeCycleRecorded -and $Evidence.StopOnGateFailRecorded
    $budgetDone = $Evidence.Budget30Recorded -and $Evidence.Budget90Recorded -and $Evidence.CleanStopRecorded -and $Evidence.PartialVerificationRecorded
    $workflowDone = $Evidence.WorkflowNoteExists -and $Evidence.OperationTiedToChecks -and $Evidence.ReflectionExists -and $Evidence.WorkflowPromptExists

    $text = Set-TaskState $text "Re-read the DCS base" $baseDone
    $text = Set-TaskState $text 'Review `mcp-setup.md`' $Evidence.DcsBaseExists
    $text = Set-TaskState $text 'Confirm `--expand 4.3.2` is still a compatibility target' $Evidence.ExpandTargetRecorded
    $text = Set-TaskState $text "Confirm DCS-5, DCS-6, and DCS-7 remain gated" $Evidence.HigherLayersGated
    $text = Set-TaskState $text "Prepare the DCS handoff packet" $handoffDone
    $text = Set-TaskState $text 'Create `docs\dcs\DCS_HANDOFF_PACKET.md`' $Evidence.HandoffExists
    $text = Set-TaskState $text "List source evidence paths" $Evidence.SourceEvidenceRecorded
    $text = Set-TaskState $text "Record layer statuses" $Evidence.LayerStatusesRecorded
    $text = Set-TaskState $text "Add the next bounded prompt" $Evidence.NextPromptExists
    $text = Set-TaskState $text "Define cycle compatibility" $cycleDone
    $text = Set-TaskState $text 'Document `--cycle 1`' $Evidence.Cycle1Recorded
    $text = Set-TaskState $text 'Document `--cycle 2`' $Evidence.Cycle2Recorded
    $text = Set-TaskState $text "Require a handoff packet before cycling" $Evidence.HandoffBeforeCycleRecorded
    $text = Set-TaskState $text "Stop when a layer gate fails" $Evidence.StopOnGateFailRecorded
    $text = Set-TaskState $text "Define budget-time compatibility" $budgetDone
    $text = Set-TaskState $text 'Document `--budget-time 30m`' $Evidence.Budget30Recorded
    $text = Set-TaskState $text 'Document `--budget-time 90m`' $Evidence.Budget90Recorded
    $text = Set-TaskState $text "Require clean stop status" $Evidence.CleanStopRecorded
    $text = Set-TaskState $text "Record partial verification honestly" $Evidence.PartialVerificationRecorded
    $text = Set-TaskState $text "Convert stable DCS into workflow" $workflowDone
    $text = Set-TaskState $text "Identify the first reusable workflow note" $Evidence.WorkflowNoteExists
    $text = Set-TaskState $text "Keep DCS-3 operations tied to verified local checks" $Evidence.OperationTiedToChecks
    $text = Set-TaskState $text "Add DCS-4 reflection after the first run" $Evidence.ReflectionExists
    $text = Set-TaskState $text "Write the next workflow-building prompt" $Evidence.WorkflowPromptExists
    $text = Update-QuestProgress $text
    return Save-QuestIfChanged $path $text
}

function Invoke-McpQuestSync {
    $evidence = Get-McpEvidence
    $updated = @()
    if (Update-BridgeQuest $evidence) { $updated += "MCP Bridge Groundwork" }
    if (Update-ToolSurfaceQuest $evidence) { $updated += "MCP Tool Surface Gate" }
    if (Update-LocalConnectionQuest $evidence) { $updated += "MCP Local Connection Trial" }
    if (Update-DcsQuest $evidence) { $updated += "MCP DCS Workflow Runway" }

    if ($updated.Count -gt 0) {
        Write-WatchLog ("updated quests: " + ($updated -join ", "))
    } else {
        Write-WatchLog "scan complete; no MCP quest checkbox changes"
    }

    return $updated
}

Write-WatchLog "starting MCP quest watcher; root=$McpRoot interval=${IntervalSeconds}s once=$Once"

do {
    try {
        Invoke-McpQuestSync | Out-Null
    } catch {
        Write-WatchLog "error: $($_.Exception.Message)"
    }

    if ($Once) {
        break
    }

    Start-Sleep -Seconds $IntervalSeconds
} while ($true)
