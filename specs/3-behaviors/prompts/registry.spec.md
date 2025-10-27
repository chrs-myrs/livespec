---
derives-from:
  - specs/3-behaviors/five-phases.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Without prompt registry, users and AI agents cannot navigate methodology or understand prompt relationships
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/ai-discoverability.spec.md
  - specs/2-strategy/architecture.spec.md
---

# Prompt Registry

## Requirements
- [!] LiveSpec provides exactly 24 prompts organized by five phases (DEFINE, DESIGN, BUILD, VERIFY, EVOLVE) plus utilities, with clear phase assignments, output specifications, and relationships to behaviors.
  - Each prompt has corresponding behavior spec in specs/3-behaviors/prompts/
  - Phase 0 (DEFINE): 4 prompts establishing foundation
  - Phase 1 (DESIGN): 3 prompts specifying solution
  - Phase 2 (BUILD): 2 prompts implementing code
  - Phase 3 (VERIFY): 2 prompts validating correctness
  - Phase 4 (EVOLVE): 5 prompts maintaining synchronisation
  - Utils: 8 prompts for special situations (workflow, improvement, generators)
  - Registry matches five-phases.spec.md structure
  - All prompt paths and outputs documented accurately
  - Bidirectional links maintained (prompts → specs, specs → prompts)

## Prompt Inventory

### Phase 0: DEFINE (4 prompts)
Establish problem space and constraints.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 0a-setup-workspace | 0a-setup-workspace.spec.md | specs/workspace/*.spec.md | Create constitution, patterns, workflows |
| 0b-define-problem | 0b-define-problem.spec.md | PURPOSE.md | Articulate problem statement |
| 0f-identify-constraints | 0f-identify-constraints.spec.md | specs/1-requirements/strategic/constraints.spec.md | Document non-negotiable boundaries |
| 0d-assess-complexity | 0d-assess-complexity.spec.md | var/complexity-assessment.md | Evaluate project scope and approach |

### Phase 1: DESIGN (3 prompts)
Design solution architecture.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 1a-design-architecture | 1a-design-architecture.spec.md | specs/2-strategy/architecture.spec.md | Define system structure and components |
| 1b-define-behaviors | 1b-define-behaviors.spec.md | specs/3-behaviors/*.spec.md | Specify observable outcomes |
| 1c-create-contracts | 1c-create-contracts.spec.md | specs/3-contracts/*.spec.md | Define API/data interfaces |

### Phase 2: BUILD (2 prompts)
Implement the solution.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 2a-implement-from-specs | 2a-implement-from-specs.spec.md | Code satisfying specs | Implement behaviors following specifications |
| 2b-create-tests | 2b-create-tests.spec.md | Tests validating behaviors | Create validation tests |

### Phase 3: VERIFY (2 prompts)
Validate solution meets requirements.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 3a-run-validation | 3a-run-validation.spec.md | var/validation-report.md | Execute validation tests and document results |
| 3b-acceptance-review | 3b-acceptance-review.spec.md | var/acceptance-review.md | Stakeholder approval process |

### Phase 4: EVOLVE (5 prompts)
Maintain synchronisation between specs and code.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 4a-detect-drift | 4a-detect-drift.spec.md | var/drift-reports/*.md | Identify spec-code misalignment |
| 4b-extract-specs | 4b-extract-specs.spec.md | specs/3-behaviors/*.spec.md | Generate specs from existing code |
| 4c-sync-complete | 4c-sync-complete.spec.md | Updated specs | Confirm synchronisation restored |
| 4d-regenerate-agents | 4d-regenerate-agents.spec.md | AGENTS.md | Regenerate AI agent configuration |
| 4e-validate-extractions | 4e-validate-extractions.spec.md | Promoted specs | Review low-confidence extracted specs |

### Utils (8 prompts)
Special situation handlers and continuous improvement.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| analyze-failure | analyze-failure.spec.md | specs/failure-analysis.md | Forensic analysis when adoption fails |
| next-steps | next-steps.spec.md | Status report | Workflow orchestration and navigation |
| run-spike | run-spike.spec.md | specs/spikes/*.md | Time-boxed technical exploration |
| upgrade-methodology | utils-upgrade.spec.md | Upgraded .livespec/ | Migrate to new LiveSpec version |
| **generate-self-improvement** | **utils-generate-self-improvement.spec.md** | **prompts/generated/self-improve.md** | **Generate project-specific improvement analysis prompt** |
| **generate-internalise-learnings** | **utils-generate-internalise-learnings.spec.md** | **prompts/generated/internalise-learnings.md** | **Generate project-specific learning capture prompt** |
| self-improve *(generated)* | utils-self-improve.spec.md | Improvement recommendations | Strategic project-wide analysis for systematic improvements |
| internalise-learnings *(generated)* | utils-internalise-learnings.spec.md | Spec updates | Tactical conversation analysis for immediate learning capture |

## Validation

- Registry lists exactly 24 prompts (4+3+2+2+5+8)
- All prompts have corresponding behavior specs in specs/3-behaviors/prompts/
- Phase assignments match five-phases.spec.md definitions
- Output paths documented for each prompt
- Bidirectional links maintained (prompts reference specs, specs reference prompts)
- Registry enables AI agents to navigate methodology
- Utils prompts handle special situations (failure, navigation, exploration, upgrade, continuous improvement)
- Generator utils create customized prompts tailored to project specifics
- Generated utils (self-improve, internalise-learnings) adapt to project PURPOSE and spec structure
