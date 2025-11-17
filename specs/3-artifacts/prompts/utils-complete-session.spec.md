---
criticality: IMPORTANT
failure_mode: Session completion prompt produces inaccurate analysis or unclear guidance
derives_from:
  - specs/3-behaviors/session-completion.spec.md
governed_by:
  - specs/workspace/constitution.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
specifies:
  - dist/prompts/utils/complete-session.md
---

# Complete Session Prompt

## Requirements

### Session End Detection Guidance

- [!] Prompt guides agent to detect session completion signals
  - Task completed successfully (all todos done)
  - Context approaching 150K tokens (75% of 200K budget)
  - Natural stopping point (ready to commit, switching tasks)
  - User stuck (repeated attempts, no progress)
  - Agent completes eagerly, not waiting for explicit request

### Compliance Scoring Guidance

- [!] Prompt provides clear scoring instructions for both dimensions
  - Process compliance: 4-layer breakdown with point allocation (0-8 total)
  - Focus efficiency: 4-dimension breakdown with point allocation (0-13 total)
  - Context efficiency: Signal-to-noise calculation with scoring thresholds
  - Evidence-based scoring (specific examples from session)
  - Classification into Perfect/Good/Fair/Poor levels

### Context Analysis Guidance

- [!] Prompt guides agent to analyze context efficiency
  - Identify sections referenced (what was actually used)
  - Identify sections unused (what was noise)
  - Calculate signal-to-noise ratio (sections used / total sections)
  - Detect redundancy between CLAUDE.md and AGENTS.md
  - Award context efficiency points based on ratio thresholds

### Feedback Generation Guidance

- [!] Prompt guides agent to identify methodology gaps
  - What LiveSpec guidance was unclear or missing
  - What prompts were hard to use
  - What caused confusion or extra work
  - What context sections were irrelevant
  - Focus on problems only (no praise in feedback file)

### Report Format Guidance

- [!] Prompt specifies concise user report format
  - Maximum 15 lines total
  - Sections: Accomplished, Compliance, Highlights, Improvements
  - Actionable improvements (specific suggestions)
  - Encourages fresh session

### File Write Guidance

- [!] Prompt provides clear instructions for saving data
  - Project metadata detection (git remote or directory name)
  - JSON structure with all required fields
  - Markdown feedback format (max 10 lines)
  - Directory creation if needed
  - Graceful degradation if write fails

### Error Handling Guidance

- [!] Prompt ensures robust execution
  - Show report even if file write fails
  - Silent failure for file operations (don't break session)
  - Proceed with completion regardless of storage issues
  - Always encourage fresh session

## Validation

- [ ] Agent detects task completion and triggers analysis
- [ ] Agent detects context >150K tokens and recommends completion
- [ ] Process compliance scored correctly with layer breakdown
- [ ] Focus efficiency scored correctly with dimension breakdown
- [ ] Signal-to-noise ratio calculated (sections used / total)
- [ ] Context redundancy detected between CLAUDE.md and AGENTS.md
- [ ] Report shown to user in ≤15 lines
- [ ] JSON written with correct structure to ~/.claude/livespec/compliance/
- [ ] Markdown feedback written in ≤10 lines to ~/.claude/livespec/feedback/
- [ ] Project name detected from git remote or directory
- [ ] Directories created automatically if missing
- [ ] Session completes gracefully if file write fails
- [ ] Fresh session encouraged after completion
- [ ] Feedback focuses on problems only (no praise)
- [ ] Improvements are specific and actionable
