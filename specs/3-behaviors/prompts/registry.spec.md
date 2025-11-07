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
- [!] LiveSpec provides exactly 28 prompts organized by five phases (DEFINE, DESIGN, BUILD, VERIFY, EVOLVE) plus utilities, with clear phase assignments, output specifications, and relationships to behaviors.
  - Each prompt has corresponding behavior spec in specs/3-behaviors/prompts/
  - Phase 0 (DEFINE): 8 prompts establishing foundation (quick-start + customize + validation)
  - Phase 1 (DESIGN): 3 prompts specifying solution
  - Phase 2 (BUILD): 2 prompts implementing code
  - Phase 3 (VERIFY): 2 prompts validating correctness
  - Phase 4 (EVOLVE): 5 prompts maintaining synchronisation
  - Utils: 8 prompts for special situations (workflow, improvement, generators, validation)
  - Registry matches five-phases.spec.md structure
  - All prompt paths and outputs documented accurately
  - Bidirectional links maintained (prompts → specs, specs → prompts)

## Prompt Inventory

### Phase 0: DEFINE (8 prompts)
Establish problem space and constraints.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 0a-quick-start | 0a-quick-start.spec.md | specs/workspace/*.spec.md | Zero-question setup (5 min, defaults) |
| 0b-customize-workspace | 0b-customize-workspace.spec.md | specs/workspace/*.spec.md | Full customization (20-30 min, tailored) |
| 0c-define-problem | 0c-define-problem.spec.md | PURPOSE.md | Articulate problem statement |
| 0d-define-outcomes | 0d-define-outcomes.spec.md | specs/1-requirements/strategic/outcomes.spec.md | Define high-level requirements |
| 0e-assess-complexity | 0e-assess-complexity.spec.md | var/complexity-assessment.md | Evaluate project scope and approach |
| 0f-evaluate-research-needs | 0f-evaluate-research-needs.spec.md | var/research-needs.md | Determine if UX research required |
| 0g-identify-constraints | 0g-identify-constraints.spec.md | specs/1-requirements/strategic/constraints.spec.md | Document non-negotiable boundaries |
| 0x-validate-understanding | 0x-validate-understanding.spec.md | None (validation only) | Verify conceptual understanding before implementation |

### Phase 1: DESIGN (4 prompts)
Design solution architecture.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 1a-document-ux-flows | 1a-document-ux-flows.spec.md | research/flows/*.md | Document user interaction flows before architecture |
| 1b-design-architecture | 1b-design-architecture.spec.md | specs/2-strategy/architecture.spec.md | Define system structure and components |
| 1c-define-behaviors | 1c-define-behaviors.spec.md | specs/3-behaviors/*.spec.md | Specify observable outcomes |
| 1d-create-contracts | 1d-create-contracts.spec.md | specs/3-contracts/*.spec.md | Define API/data interfaces |

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

### Phase 4: EVOLVE (6 prompts)
Maintain synchronisation between specs and code.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 4a-detect-drift | 4a-detect-drift.spec.md | var/drift-reports/*.md | Identify spec-code misalignment |
| 4b-extract-specs | 4b-extract-specs.spec.md | specs/3-behaviors/*.spec.md | Generate specs from existing code |
| 4c-sync-complete | 4c-sync-complete.spec.md | Updated specs | Confirm synchronisation restored |
| 4d-regenerate-agents | 4d-regenerate-agents.spec.md | AGENTS.md | Regenerate AI agent configuration |
| 4e-validate-extractions | 4e-validate-extractions.spec.md | Promoted specs | Review low-confidence extracted specs |
| 4f-document-implementation | 4f-document-implementation.spec.md | var/implementation-reports/*.md | Create comprehensive implementation feedback report |

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

- Registry lists exactly 30 prompts (8+4+2+2+6+8)
- All prompts have corresponding behavior specs in specs/3-behaviors/prompts/
- Phase assignments match five-phases.spec.md definitions
- Output paths documented for each prompt
- Bidirectional links maintained (prompts reference specs, specs reference prompts)
- Registry enables AI agents to navigate methodology
- Phase 0 includes conceptual validation prompt (0x-validate-understanding)
- Utils prompts handle special situations (failure, navigation, exploration, upgrade, continuous improvement, validation, auditing)
- Generator utils create customized prompts tailored to project specifics
- Generated utils (self-improve, internalise-learnings) adapt to project PURPOSE and spec structure
