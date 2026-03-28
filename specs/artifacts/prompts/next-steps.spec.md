---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without workflow orchestration guidance, users become lost in methodology and abandon adoption when unsure of next steps
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
derives-from:
  - specs/workspace/workflows.spec.md
  - specs/features/three-modes.spec.md
specifies: dist/prompts/utils/next-steps.md
---

# Next Steps Workflow Orchestrator Prompt

## Requirements
- [!] Prompt analyzes project state and recommends next actions, determining current mode (DEFINE/DESIGN/EVOLVE) by checking what exists (PURPOSE, requirements, architecture, specs) and providing specific prompt to execute with rationale, enabling users to navigate methodology when lost or transitioning between modes.
  - Triggers: Starting project, lost track of mode, finished mode unsure what's next, returning after time away
  - State analysis: Checks foundation (PURPOSE, requirements, constraints, workspace), design (architecture, behaviors, contracts), maintenance (last health check, spec changes)
  - Mode determination: Maps state to Mode 0-2
  - Issue identification: Blockers (missing prerequisites), warnings (incomplete mode, long gap, missing workspace)
  - Output format: Current state, completed items, missing items, issues, recommended next action with why/output
  - Decision tree: Covers starting from scratch, incomplete foundation, all modes, special situations (spec health, complexity, confusion)
  - Integration tips: Teams (sprint planning, onboarding), solo (after breaks, context-switching), AI agents
  - Example outputs: Just starting, design complete, spec health issue detected

## Prompt Outputs

**Primary outputs:**
- Status analysis markdown showing:
  - Current mode (0-2)
  - Status (starting/in progress/blocked/needs attention)
  - Completed items
  - Missing or incomplete
  - Issues found
  - Recommended next action (specific prompt path)
  - Upcoming milestones
  - Tips for current mode

**Analysis components:**
- Foundation check (PURPOSE, requirements, constraints, workspace)
- Design check (architecture, behaviors, contracts)
- Maintenance check (last updates, spec health)

**Decision tree coverage:**
- Starting from scratch → 0a-quick-start
- Foundation incomplete → 0b-define-problem, 0c-identify-constraints
- Design mode → 1a-design-architecture, 1b-define-behaviors, 1c-create-contracts
- Evolve mode → 4a-detect-drift, 4b-extract-specs, 4d-regenerate-context
- Special situations → analyze-failure, run-spike, next-steps (self-reference)

**Validation:**
- Analysis identifies current mode accurately
- Recommendation is specific prompt path (not vague)
- Rationale explains why this is next step
- Decision tree covers all transitions
- Output format consistent
- Integration tips actionable

## Validation

- Prompt exists at dist/prompts/utils/next-steps.md
- Prompt has spec: frontmatter reference
- Checks three state categories (foundation, design, maintenance)
- Determines mode 0-2 based on state
- Decision tree covers all 3 modes plus special situations
- Output includes specific prompt recommendation with rationale
- Integration tips for teams, solo developers, AI agents
- Example outputs demonstrate typical scenarios
- Self-referential (references itself as "when lost or confused")
