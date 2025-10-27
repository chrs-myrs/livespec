---
specifies: prompts/utils/detect-phase-restart.md
criticality: IMPORTANT
failure_mode: AI agents jump to wrong phase for sub-features, skip necessary research/definition
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
informed-by:
  - feedback/talevenforge-accessible-reading-ui-failure.md
---

# Prompt Behavior: Detect Phase Restart

## Requirements
- [!] Prompt helps AI agent determine whether existing project needs Phase 0 restart for new work, preventing phase jumping that skips necessary research/definition.
  - Identifies when feature is actually sub-project requiring Phase 0 (research, outcomes, constraints)
  - Distinguishes continuation (stay in current phase) from restart (go to Phase 0)
  - Considers: UX rethink, new user-facing features, architectural changes, accessibility requirements
  - Prevents bypassing research for critical domains (accessibility, safety, novel UX)
  - Outputs clear decision: "Restart at Phase 0" or "Continue current phase" with rationale

## Context

Use when:
- Working on existing project (Phase 2/3/4 complete)
- Considering new feature or redesign
- Uncertain whether to continue or restart phases
- Major change feels different from current project scope

## Prerequisites

- Project has completed at least one full phase cycle
- Specs directory exists with prior phase outputs
- New work request that feels substantial

## Outputs

- Clear phase decision: RESTART at Phase 0 or CONTINUE current phase
- Rationale explaining why
- If RESTART: Which Phase 0 prompts to run and why
- If CONTINUE: Which prompts/phases apply to the work

## Validation

- Decision is appropriate for scope of new work
- Rationale references project characteristics
- Restart guidance includes specific Phase 0 prompts needed
- Accessibility/safety work always triggers restart evaluation
- Agent doesn't bypass research for critical domains

## Success Criteria

- Major UX rethinks correctly identified as Phase 0 restart
- Accessibility features trigger research evaluation
- Architectural changes restart at constraints definition
- Bug fixes correctly identified as continuation
- Agent explains reasoning clearly

## Error Handling

**If project has no existing specs:**
- Not a restart decision - this is initial Phase 0
- Guide to `.livespec/0-define/0a-setup-workspace.md`

**If work scope unclear:**
- Ask clarifying questions before decision
- Better to restart unnecessarily than skip research

**If accessibility/safety domain:**
- Default to RESTART with research evaluation
- Make research mandatory callout clear
