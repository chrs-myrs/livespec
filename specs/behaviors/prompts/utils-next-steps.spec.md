---
specifies: dist/prompts/utils/next-steps.md
derives_from:
  - specs/workspace/workflows.spec.md
  - specs/behaviors/five-phases.spec.md
criticality: IMPORTANT
failure_mode: Without workflow orchestration guidance, users become lost in methodology and abandon adoption when unsure of next steps
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Next Steps Workflow Orchestrator Prompt

## Requirements
- [!] Prompt analyzes project state and recommends next actions, determining current phase (DEFINE/DESIGN/BUILD/VERIFY/EVOLVE) by checking what exists (PURPOSE, requirements, architecture, code, tests) and providing specific prompt to execute with rationale, enabling users to navigate methodology when lost or transitioning between phases.
  - Triggers: Starting project, lost track of phase, finished phase unsure what's next, returning after time away
  - State analysis: Checks foundation (PURPOSE, requirements, constraints, workspace), design (architecture, behaviors, contracts), implementation (code, tests), maintenance (last drift check, code changes)
  - Phase determination: Maps state to Phase 0-4
  - Issue identification: Blockers (missing prerequisites), warnings (incomplete phase, long gap, missing workspace)
  - Output format: Current state, completed items, missing items, issues, recommended next action with why/output/time-estimate
  - Decision tree: Covers starting from scratch, incomplete foundation, all phases, special situations (drift, complexity, confusion)
  - Integration tips: Teams (sprint planning, onboarding), solo (after breaks, context-switching), AI agents
  - Example outputs: Just starting, design complete, drift detected

## Prompt Outputs

**Primary outputs:**
- Status analysis markdown showing:
  - Current phase (0-4)
  - Status (starting/in progress/blocked/drifted)
  - Completed items ✅
  - Missing or incomplete ⚠️
  - Issues found 🔴
  - Recommended next action (specific prompt path)
  - Upcoming milestones
  - Tips for current phase

**Analysis components:**
- Foundation check (PURPOSE, requirements, constraints, workspace)
- Design check (architecture, behaviors, contracts)
- Implementation check (code, tests, spec alignment)
- Maintenance check (last updates, drift gap)

**Decision tree coverage:**
- Starting from scratch → 0a-setup-workspace
- Foundation incomplete → 0b-define-problem, 0c-identify-constraints
- Design phase → 1a-design-architecture, 1b-define-behaviors, 1c-create-contracts
- Build phase → 2a-implement-from-specs, 2b-create-tests
- Verify phase → 3a-run-validation, 3b-acceptance-review
- Evolve phase → 4a-detect-drift, 4b-extract-specs, 4c-sync-complete
- Special situations → analyze-failure, run-spike, next-steps (self-reference)

**Validation:**
- Analysis identifies current phase accurately
- Recommendation is specific prompt path (not vague)
- Rationale explains why this is next step
- Decision tree covers all transitions
- Output format consistent
- Integration tips actionable

## Validation

- Prompt exists at dist/prompts/utils/next-steps.md
- Prompt has spec: frontmatter reference
- Checks four state categories (foundation, design, implementation, maintenance)
- Determines phase 0-4 based on state
- Decision tree covers all 5 phases plus special situations
- Output includes specific prompt recommendation with rationale
- Integration tips for teams, solo developers, AI agents
- Example outputs demonstrate typical scenarios
- Self-referential (references itself as "when lost or confused")
