---
criticality: IMPORTANT
failure_mode: Cannot measure agent adherence to spec-first protocol, leading to undetected process bypasses
derives_from:
  - specs/workspace/constitution.spec.md
supports:
  - Continuous process improvement
  - Agent performance comparison
  - Compliance trend analysis
specifies:
  - scripts/measure-agent-compliance.sh
  - dist/prompts/utils/measure-session-compliance.md
---

# Agent Compliance Measurement

## Requirements

### Session Compliance Scoring

- [!] System calculates process compliance score (0-8 points) for sessions creating permanent files
  - Layer 1 (TodoWrite Gate): 2 points maximum
    - 1 point: TodoWrite added before file operations
    - 1 point: Todo marked complete after spec created
  - Layer 2 (Validation Check): 2 points maximum
    - 1 point: `check-requires-spec.sh` executed
    - 1 point: Exit code respected (stopped if validation failed)
  - Layer 3 (Plan Mode): 3 points maximum
    - 1 point: Plan presented before creating permanent file
    - 1 point: Plan includes spec creation step
    - 1 point: Plan shows specific spec path
  - Layer 4 (Pre-commit): 1 point maximum
    - 1 point: Commit passed pre-commit validation

### Focus Efficiency Scoring

- [!] System calculates focus efficiency score (0-13 points) for all sessions
  - Tool efficiency: 5 points maximum
    - +1 point: Read used instead of Bash cat
    - +1 point: Grep used instead of Bash grep
    - +1 point: Glob used instead of Bash find
    - +2 points: Parallel tool calls when operations independent
  - Context navigation: 3 points maximum
    - +1 point: AGENTS.md referenced before full prompt fetch
    - +1 point: Reference Library used for deep detail
    - -1 point: Unnecessary full prompt fetch
  - Task focus: 2 points maximum
    - +2 points: Stayed on original task without scope creep
    - +1 point: Asked clarifying question before assumption
    - -2 points: Significant scope creep or unasked exploration
  - Context efficiency: 3 points maximum
    - Signal-to-noise ratio (percentage of loaded context actually used)
    - +3 points: >60% signal-to-noise ratio (high efficiency)
    - +2 points: 40-60% signal-to-noise ratio (moderate efficiency)
    - +1 point: 20-40% signal-to-noise ratio (low efficiency)
    - +0 points: <20% signal-to-noise ratio (very low efficiency)

### Session Logging

- [!] System captures session events in structured JSON format
  - Local file location: `var/compliance/session-YYYY-MM-DD-HHMMSS.json`
  - Global file location: `~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-{project}.json`
  - Dual storage: Saves to both local and global locations
  - Global directory created automatically if doesn't exist
  - Graceful degradation: Local save succeeds even if global save fails
  - Events logged: TodoWrite, validation checks, plan presentations, tool usage, context fetches
  - Event schema includes: timestamp, event type, action, compliance layer, points awarded
  - Session log includes: start time, end time, task description, total scores, project metadata
  - Project metadata: project name, absolute path, git remote URL, LiveSpec version
  - Context analysis captured: tokens loaded, sections referenced, signal-to-noise ratio, redundant content detected

### Compliance Reporting

- [!] System generates session compliance report showing:
  - Overall compliance score (percentage)
  - Layer-by-layer breakdown with pass/fail/warn indicators
  - Focus efficiency breakdown (tool/context nav/task/context efficiency)
  - Signal-to-noise analysis (context loaded vs used)
  - Specific recommendations for improvement
  - Comparison to project baseline averages
  - Context optimization suggestions when signal-to-noise <60%

### Compliance Levels

- [!] System classifies sessions into compliance levels:
  - Perfect (100%): All 8 compliance points + 11+ focus points (85%+ of 13)
  - Good (75-99%): 6-7 compliance points + 8+ focus points (60%+ of 13)
  - Fair (50-74%): 4-5 compliance points + any focus score
  - Poor (<50%): 0-3 compliance points

## Validation

- [ ] Session with perfect spec-first compliance scores 8/8
- [ ] Session bypassing TodoWrite gate scores ≤6/8
- [ ] Session using Read instead of Bash cat earns tool efficiency point
- [ ] Session asking clarifying question earns task focus point
- [ ] Session with scope creep loses focus points
- [ ] Signal-to-noise ratio calculated correctly (sections used / total sections)
- [ ] Context efficiency scoring: >60% = 3 points, 40-60% = 2 points, 20-40% = 1 point, <20% = 0 points
- [ ] Report shows signal-to-noise analysis with context loaded vs used
- [ ] Report identifies redundant content between CLAUDE.md and AGENTS.md
- [ ] Report suggests context optimization when signal-to-noise <60%
- [ ] Report shows layer-by-layer breakdown with specific scores
- [ ] Report includes actionable recommendations
- [ ] Report compares to project baseline when available
- [ ] JSON log parses successfully with documented schema
- [ ] Session log saved to local location (var/compliance/)
- [ ] Session log saved to global location (~/.claude/livespec/compliance/)
- [ ] Global directory created automatically if missing
- [ ] Project metadata detected correctly (name from git or directory)
- [ ] Project metadata includes absolute path
- [ ] Git remote URL captured when available
- [ ] Global save failure doesn't prevent local save
- [ ] Global session log named with project: YYYY-MM-DD-HHMMSS-projectname.json
- [ ] Measurement works across different AI agents (Claude, Copilot, Cursor)
