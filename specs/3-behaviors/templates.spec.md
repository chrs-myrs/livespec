---
criticality: IMPORTANT
failure_mode: Without template management, users struggle to bootstrap specs, agents lack reusable verification content, and key processes become embedded in prompts instead of manageable templates
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
derives-from:
  - specs/workspace/patterns.spec.md (template architecture pattern)
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (minimal maintenance, voluntary adoption)
guided-by:
  - specs/2-strategy/architecture.spec.md
---

# Template Management

## Requirements
- [!] LiveSpec provides reusable markdown templates for bootstrap (workspace specs) and enforcement (agent verification), stored in `.livespec/templates/`, referenced by specs, inserted by prompts, and distributed via dist/.
  - **Template Categories:**
    - Workspace templates (`.livespec/templates/workspace/`) - Bootstrap development methodology specs
    - Agent templates (`.livespec/templates/agents/`) - Reusable verification/warning content for AGENTS.md
    - Domain templates (`.livespec/templates/governance/`, `operations/`) - Domain-specific bootstrap
  - Each template is complete standalone markdown (not fragment)
  - Templates follow descriptive naming (e.g., `constitution.spec.md.template`, `pre-implementation-verification.md`)
  - Specs reference templates explicitly by path
  - Prompts insert template content during generation
  - Templates copied to `dist/templates/` for distribution
  - Template updates trigger regeneration of dependent files

## Workspace Templates (Bootstrap)

**Purpose:** Enable users to quickly bootstrap development methodology specifications

**Location:** `.livespec/templates/workspace/`

**constitution.spec.md.template:**
- Defines project governance principles
- Placeholder for 3-5 core development principles
- Examples: MSL minimalism, bidirectional sync, simplicity over features
- Validation criteria placeholders

**patterns.spec.md.template:**
- Defines coding and specification patterns
- Placeholder for file naming, code organization, documentation standards
- Examples: kebab-case, .spec.md extension, MSL format
- Pattern verification placeholders

**workflows.spec.md.template:**
- Defines development workflows
- Placeholder for feature development, bug fixes, spec updates, releases
- Examples: spec → implement → test → review
- Workflow adherence placeholders

## Agent Templates (Verification & Enforcement)

**Purpose:** Provide reusable verification content for AGENTS.md to prevent methodology violations

**Location:** `.livespec/templates/agents/`

**Pre-implementation verification:**
- Checklist before implementing any deliverable
- Verifies spec exists, tests exist (if TDD), plan includes methodology steps
- Guides to Phase 1 (DESIGN) if prerequisites missing

**No plumbing exception warning:**
- Prevents "just wiring" categorization trap
- Lists red flag phrases indicating skipped specification
- Includes real example from LiveSpec's own violation

**Self-check questions:**
- Questions agents ask themselves before implementing
- Spec-first check, TDD check, methodology compliance check
- Meta-check for execution mode bypassing methodology

**Plan review checklist:**
- Methodology compliance verification before user approval
- Checks for spec creation, test creation, workflow reference
- Reports compliance status to user

**Distribution to target projects:**
- Agent templates distributed in `dist/templates/agents/`
- Users copy `dist/` → `.livespec/` (complete adoption) OR
- Users copy `dist/templates/` → `.livespec/templates/` (selective adoption)
- Templates accessible at `.livespec/templates/agents/` in target projects

**Usage flow in target projects:**
1. Templates referenced by `specs/workspace/workspace-agent.spec.md`
2. Read by `.livespec/prompts/4-evolve/4d-regenerate-agents.md` during AGENTS.md generation
3. Inserted into AGENTS.md START section
4. Provide structural enforcement for target project agents

**Critical dependency:** 4d-regenerate-agents.md requires `.livespec/templates/agents/` to exist. If target project only copied `prompts/`, AGENTS.md generation will fail or lack verification content.

## Validation

**Workspace templates:**
- Three templates exist in `dist/templates/workspace/` (constitution, patterns, workflows)
- Each follows MSL format with appropriate criticality
- Each provides clear placeholder instructions
- Referenced in Phase 0 prompt (0a-setup-workspace.md)

**Agent templates:**
- Four templates exist in `dist/templates/agents/`:
  - pre-implementation-verification.md
  - no-plumbing-exception.md
  - self-check-questions.md
  - plan-review-checklist.md
- Each is complete standalone markdown section
- Referenced in `specs/workspace/workspace-agent.spec.md`
- Inserted by `prompts/4-evolve/4d-regenerate-agents.md`
- Visible in generated AGENTS.md START section

**Template architecture:**
- `dist/templates/README.md` explains template usage
- Specs reference templates by explicit path
- Prompts insert template content during generation
- Template updates trigger file regeneration (e.g., AGENTS.md)
- Distribution copies templates to target projects
