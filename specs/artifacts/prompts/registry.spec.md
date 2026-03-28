---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without prompt registry, users and AI agents cannot navigate methodology or understand prompt relationships
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/strategy/architecture.spec.md
derives-from:
  - specs/features/three-modes.spec.md
  - specs/workspace/workflows.spec.md
specifies: []
---

# Prompt Registry

## Requirements
- [!] LiveSpec provides prompts organized by three modes (DEFINE, DESIGN, EVOLVE) plus utilities, with clear mode assignments, output specifications, and relationships to behaviors.
  - Each prompt has corresponding behavior spec in specs/artifacts/prompts/
  - Mode 0 (DEFINE): 8 prompts establishing foundation (quick-start + customize + validation)
  - Mode 1 (DESIGN): 4 prompts specifying solution
  - Mode 2 (EVOLVE): 6 prompts maintaining spec health
  - Utils: 14 prompts for special situations (session completion, strategic improvements, health diagnostics, workspace optimization, workflow analysis, spikes, upgrade, audits, slash command generation)
  - Registry matches three-modes.spec.md structure
  - All prompt paths and outputs documented accurately
  - Bidirectional links maintained (prompts → specs, specs → prompts)

## Prompt Inventory

### Mode 0: DEFINE (8 prompts)
Establish problem space and constraints.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 0a-quick-start | 0a-quick-start.spec.md | specs/workspace/*.spec.md | Zero-question setup (5 min, defaults) |
| 0b-customize-workspace | 0b-customize-workspace.spec.md | specs/workspace/*.spec.md | Full customization (20-30 min, tailored) |
| 0c-define-problem | 0c-define-problem.spec.md | PURPOSE.md | Articulate problem statement |
| 0d-define-outcomes | 0d-define-outcomes.spec.md | specs/foundation/outcomes.spec.md | Define high-level requirements |
| 0e-assess-complexity | 0e-assess-complexity.spec.md | var/complexity-assessment.md | Evaluate project scope and approach |
| 0f-evaluate-research-needs | 0f-evaluate-research-needs.spec.md | var/research-needs.md | Determine if UX research required |
| 0g-identify-constraints | 0g-identify-constraints.spec.md | specs/foundation/constraints.spec.md | Document non-negotiable boundaries |
| 0x-validate-understanding | 0x-validate-understanding.spec.md | None (validation only) | Verify conceptual understanding |

### Mode 1: DESIGN (4 prompts)
Design spec architecture.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 1a-document-ux-flows | 1a-document-ux-flows.spec.md | research/flows/*.md | Document user interaction flows before architecture |
| 1b-design-architecture | 1b-design-architecture.spec.md | specs/strategy/architecture.spec.md | Define system structure and components |
| 1c-define-behaviors | 1c-define-behaviors.spec.md | specs/features/*.spec.md | Specify observable outcomes |
| 1d-create-contracts | 1d-create-contracts.spec.md | specs/interfaces/*.spec.md | Define API/data interfaces |

### Mode 2: EVOLVE (6 prompts)
Maintain spec health and extract learnings.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| 4a-detect-drift | 4a-detect-drift.spec.md | var/health-reports/*.md | Identify spec health issues |
| 4b-extract-specs | 4b-extract-specs.spec.md | specs/features/*.spec.md | Extract learnings to specs |
| 4c-sync-complete | 4c-sync-complete.spec.md | Updated specs | Confirm spec updates complete |
| 4d-regenerate-context | 4d-regenerate-context.spec.md | AGENTS.md | Regenerate context tree |
| 4e-validate-extractions | 4e-validate-extractions.spec.md | Promoted specs | Review low-confidence extracted specs |
| 4f-document-implementation | 4f-document-implementation.spec.md | var/reports/*.md | Create comprehensive feedback report |

### Utils (14 prompts)
Special situation handlers and continuous improvement.

| Prompt | Spec | Output | Purpose |
|--------|------|--------|---------|
| analyze-failure | analyze-failure.spec.md | specs/failure-analysis.md | Forensic analysis when adoption fails |
| audit-context-compression | utils-audit-context-compression.spec.md | var/audits/context-*.md | Analyze context compression effectiveness |
| audit-msl-minimalism | utils-audit-msl-minimalism.spec.md | var/audits/minimalism-*.md | Check specs for over-specification using MSL principles |
| audit-spec-coverage | utils-audit-spec-coverage.spec.md | var/audits/coverage-*.md | Verify all permanent files have specifications |
| audit-workspace-scope | utils-audit-workspace-scope.spec.md | var/audits/workspace-scope-*.md | Verify workspace scope appropriateness |
| audit-workspace-specs | utils-audit-workspace-specs.spec.md | var/audits/workspace-specs-*.md | Detect bloat/redundancy in workspace specs |
| complete-session | utils-complete-session.spec.md | ~/.claude/livespec/compliance/, feedback/ | End-of-session analysis with compliance scoring and learning capture |
| generate-custom-slash-commands | utils-generate-custom-slash-commands.spec.md | .claude/commands/livespec/*.md | Generate customized Claude Code slash commands for LiveSpec utilities |
| next-steps | next-steps.spec.md | Status report | Workflow orchestration and navigation |
| reorganize-workspace | utils-reorganize-workspace.spec.md | Reorganization plan | Context optimization based on usage patterns (START/MIDDLE/END positioning) |
| run-health-report | utils-run-health-report.spec.md | var/health-reports/*.md | Diagnostic health assessment with status and remediation plans |
| run-spike | run-spike.spec.md | specs/spikes/*.md | Time-boxed technical exploration |
| suggest-improvements | utils-suggest-improvements.spec.md | Prioritized recommendations | Strategic improvement analysis based on accumulated data (registries, trends, feedback) |
| upgrade-methodology | utils-upgrade.spec.md | Upgraded .livespec/ | Migrate to new LiveSpec version |

## Validation

- Registry lists exactly 32 prompts (8+4+6+14)
- All prompts have corresponding behavior specs in specs/artifacts/prompts/
- Mode assignments match three-modes.spec.md definitions
- Output paths documented for each prompt
- Bidirectional links maintained (prompts reference specs, specs reference prompts)
- Registry enables AI agents to navigate methodology
- Mode 0 includes conceptual validation prompt (0x-validate-understanding)
- Utils prompts handle special situations (failure, navigation, exploration, upgrade, session completion, strategic improvements, health diagnostics, workspace optimization, audits, slash command generation)
- Four-level improvement taxonomy supported (session, context, strategic, diagnostic)
- Session completion integrated with learning capture
- Five audit types available (minimalism, context, coverage, workspace-specs, workspace-scope)
- Slash command generation creates discoverable commands in .claude/commands/livespec/ namespace
