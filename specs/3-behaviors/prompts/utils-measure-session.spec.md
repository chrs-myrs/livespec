---
criticality: IMPORTANT
failure_mode: Session compliance measurement produces inaccurate scores or unclear recommendations
derives_from:
  - specs/3-behaviors/measurement/agent-compliance.spec.md
governed_by:
  - specs/workspace/constitution.spec.md
specifies:
  - dist/prompts/utils/measure-session-compliance.md
---

# Measure Session Compliance Prompt

## Requirements

### Compliance Analysis

- [!] Prompt guides agent to score process compliance across four layers
  - Layer 1 (TodoWrite Gate): Evidence of TodoWrite before file creation, completion after spec
  - Layer 2 (Validation Check): Evidence of script execution and exit code respect
  - Layer 3 (Plan Mode): Evidence of plan presentation, spec creation mention, specific path
  - Layer 4 (Pre-commit): Evidence of validation pass on first attempt
  - Scoring fair: "Insufficient data" instead of penalizing when evidence unavailable

- [!] Prompt guides agent to score focus efficiency across three dimensions
  - Tool efficiency: Specialized tools (Read/Grep/Glob) vs Bash commands
  - Context navigation: AGENTS.md usage, Reference Library usage, unnecessary fetches
  - Task focus: Scope adherence, clarifying questions, scope creep detection

### Report Generation

- [!] Prompt specifies complete report structure
  - Header with session metadata (date, agent, task, compliance level)
  - Process compliance section with layer-by-layer breakdown
  - Focus efficiency section with dimension-specific scores
  - Recommendations section with 3-5 actionable items
  - Baseline comparison table (when data available)
  - Optional session log JSON structure

- [!] Prompt requires evidence-based scoring
  - Specific quotes from transcript supporting scores
  - Tool call references for tool efficiency
  - Concrete examples in recommendations
  - Transparent scoring rationale

### Exception Handling

- [!] Prompt identifies sessions where spec-first doesn't apply
  - Editing existing files (not creating new permanent files)
  - Creating temporary files (var/, generated/, .archive/)
  - Research/analysis tasks with no file creation
  - Agent doesn't penalize these sessions for missing spec-first steps

### Constructive Tone

- [!] Prompt requires improvement-focused analysis
  - Celebrates successes alongside identifying gaps
  - Explains WHY practices matter (not just compliance scores)
  - Provides concrete next steps (not abstract "do better")
  - Frames gaps as learning opportunities

## Validation

- [ ] Agent analyzes session transcript and produces complete compliance report
- [ ] Layer scores match actual evidence from transcript
- [ ] Tool efficiency score reflects actual tool usage patterns
- [ ] Recommendations specific and actionable (not generic)
- [ ] Report uses constructive tone focused on improvement
- [ ] Agent correctly identifies sessions where spec-first doesn't apply
- [ ] Session log JSON structure valid and complete
- [ ] Baseline comparison included when previous session data available
- [ ] Report markdown renders correctly with tables and formatting
- [ ] Agent provides evidence quotes supporting scores
