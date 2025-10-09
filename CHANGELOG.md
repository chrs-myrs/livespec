# LiveSpec Changelog

All notable changes to LiveSpec will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## For Users with Customizations

This changelog uses ⚠️ to mark changes affecting customized prompts/templates:
- **HIGH impact**: Must merge to maintain functionality
- **MEDIUM impact**: Should merge for improvements
- **LOW impact**: Optional, backward compatible

See `dist/prompts/utils/upgrade-methodology.md` for AI-assisted upgrade process.

---

## [Unreleased]

### Added

### Changed

### Fixed

---

## [2.2.0] - 2025-10-09

### Drift Resolution Release

This release addresses drift detected between specifications and documentation, ensuring hierarchy consistency and metaspec compliance.

**Key fixes:**
- Added missing `applies_to` frontmatter to workspace specs (constitution, workflows, patterns)
- Updated AGENTS.md Core Principles section to reflect spec-first as principle #1
- Updated CHANGELOG with previously missing commits (spec-first enforcement updates)

### Added
- **Prompt**: `prompts/utils/generate-feedback-report.md` - Optional evaluation report utility
  - *Impact*: None (new utility, doesn't affect existing workflows)
  - *Purpose*: Generate structured feedback reports for LiveSpec maintainers
- **Template**: `templates/governance/policy.spec.md.template` - Governance policy template
  - *Impact*: None (new domain template)
- **Template**: `templates/governance/procedure.spec.md.template` - Governance procedure template
  - *Impact*: None (new domain template)
- **Template**: `templates/operations/runbook.spec.md.template` - Operations runbook template
  - *Impact*: None (new domain template)
- **Template**: `templates/operations/playbook.spec.md.template` - Operations playbook template
  - *Impact*: None (new domain template)
- **Template**: `templates/strategy.spec.md.template` - Strategy specification template
  - *Impact*: None (new template)
  - *Purpose*: Template for cross-cutting technical decisions
- **File**: `dist/AGENTS.md` - Included in distribution
  - *Impact*: LOW (new file in dist/, copy to project root)
  - *Purpose*: Enable immediate AI agent discoverability upon adoption
- **File**: `dist/.livespec-version.template` - Version tracking
  - *Impact*: None (new file for upgrade detection)
- **File**: `dist/customizations.yaml.template` - Customization tracking
  - *Impact*: None (new file for AI-assisted upgrades)
- **Documentation**: `docs/domain-organization.md` - Multi-domain organization patterns
  - *Impact*: None (new documentation)

### Changed

- **⚠️ Multiple Files**: Spec-first development now principle #1 with hierarchy alignment (HIGH IMPACT)
  - *Why*: CHANGELOG was implemented without spec (commit 40411e3), violating core spec-first principle
  - *Why*: Needed to prevent future violations and maintain methodology integrity
  - *Impact*: HIGH - Affects all future development, AI agents now guide spec creation before implementation
  - *Changes*:
    - PURPOSE.md: Clarified voluntary adoption includes AI-guided methodology discipline
    - requirements.spec.md: Requirement #5 updated ("AI agents provide structured guidance" not "No enforcement mechanisms")
    - workspace/constitution.spec.md: Spec-first moved from principle #4 to principle #1
    - workspace/workflows.spec.md: Added Spec-First Guidance Workflow (essential before implementation)
    - workspace/agents.spec.md: AI agents guide (not block) spec-first development
    - prompts/2-build/2a-implement-from-specs.md: Added essential pre-flight check section
    - AGENTS.md: Added prominent spec-first guidance section after Summary
  - *Migration*: AI agents will now check for specs before implementing, guiding users to Phase 1 (DESIGN) if spec missing
  - *Note*: Behavior is guidance (supportive tone), not blocking (forceful). Preserves voluntary adoption model while ensuring methodology discipline.
  - *Commits*: 8321fd5 (initial enforcement), cd998df (hierarchy alignment correction)

- **Spec**: `specs/behaviors/changelog.spec.md` - Added retrospective specification
  - *Why*: Learning from CHANGELOG implementation-first mistake (commit 40411e3)
  - *Impact*: None (spec-only, implementation already exists)
  - *Purpose*: Document requirements that should have existed before CHANGELOG.md was implemented
  - *Note*: Demonstrates importance of spec-first even for "obvious" deliverables
  - *Commit*: 60c32e1

- **⚠️ Prompt**: `prompts/0-define/0a-setup-workspace.md` - Added Step 0 for agent bootstrap (HIGH IMPACT)
  - *Why*: Fixed discoverability gap - users couldn't effectively use prompts without AGENTS.md existing
  - *Impact*: HIGH for customized versions - Step 0 must execute FIRST (before version tracking)
  - *Changes*:
    - NEW Step 0: Bootstrap Agent Configuration (copy AGENTS.md, create symlink, verify)
    - Existing steps renumbered (Version tracking → Step 1, Domain org → Step 2, Workspace → Step 3)
    - Exit criteria restructured by step
    - Agent configuration moved to optional regeneration section
  - *Migration*: Add Step 0 before your custom steps, ensure AGENTS.md copied first

- **⚠️ Prompt**: `prompts/1-design/1a-design-architecture.md` - Fixed path and added cross-cutting concerns (MEDIUM IMPACT)
  - *Why*: AI created `specs/architecture.spec.md` instead of `specs/strategy/architecture.spec.md`
  - *Why*: User feedback: "without logging strategy debugging became a problem later"
  - *Impact*: MEDIUM - path correction + new optional checklist
  - *Changes*:
    - Line 17: Fixed path from `specs/architecture.md` to `specs/strategy/architecture.spec.md`
    - NEW section: "Consider Cross-Cutting Concerns" (observability, error handling, security, data, integration, deployment)
    - Updated exit criteria to mention strategy/ folder
  - *Migration*: Update architecture spec path, consider adding cross-cutting concerns checklist

- **⚠️ Prompt**: `prompts/utils/upgrade-methodology.md` - Complete rewrite for AI-assisted upgrade (LOW IMPACT)
  - *Why*: Enable safe, intelligent upgrades with customization awareness
  - *Impact*: LOW (utility prompt, not core workflow)
  - *Changes*: Shifted from bash-heavy to AI-native progressive merge strategy
  - *Migration*: No action needed (utility only used during upgrades)

- **Metaspec**: `standard/metaspecs/behavior.spec.md` - Added subfolder organization support
  - *Why*: Support multi-domain projects (software, governance, operations, planning)
  - *Impact*: LOW (backward compatible - flat structure still valid)
  - *Changes*: Documented subfolder patterns (behaviors/policies/, behaviors/user-features/, etc.)

- **Metaspec**: `standard/metaspecs/contract.spec.md` - Expanded beyond APIs
  - *Why*: Contracts include procedures, runbooks, workflows (not just APIs)
  - *Impact*: LOW (clarification, not breaking change)
  - *Changes*: Added examples for operational/process contracts

- **Documentation**: `PURPOSE.md` - Acknowledged multi-domain applicability
  - *Impact*: None (documentation update)
  - *Changes*: Software remains primary, governance/operations/planning noted as proven domains

- **Documentation**: `specs/strategy/architecture.spec.md` - Added multi-domain patterns
  - *Impact*: None (LiveSpec's own architecture doc)

- **Documentation**: `AGENTS.md` - Added multi-domain organization and version tracking sections
  - *Impact*: None (agent configuration, regenerate after customization)

### Fixed

- **Workspace specs metaspec compliance**: Added missing `applies_to` frontmatter to constitution.spec.md, workflows.spec.md, patterns.spec.md (metaspec requirement)
- **AGENTS.md Core Principles drift**: Updated to reflect current constitution.spec.md principle order (Specs Before Implementation now #1)
- **CHANGELOG drift**: Added missing entries for spec-first enforcement commits (cd998df, 8321fd5, 60c32e1)
- Strategy specifications now created in correct location (`specs/strategy/` not `specs/`)
- AGENTS.md now included in distribution (fixes discoverability gap)
- Cross-cutting concerns (logging, observability, error handling) now prompted early in design phase
- Agent symlink (CLAUDE.md, COPILOT.md) now created automatically in Step 0

---

## [2.1.0] - 2025-10-07

### Complete Methodology Rewrite

LiveSpec 2.1.0 represents a complete rewrite from stage-based to phase-based methodology, adopting MSL (Markdown Specification Language) and establishing a mature, production-ready framework.

### Major Changes

#### New Five-Phase Methodology
- **Phase 0: DEFINE** - Problem definition and workspace setup
- **Phase 1: DESIGN** - Solution architecture and specifications
- **Phase 2: BUILD** - Implementation from specifications
- **Phase 3: VERIFY** - Validation and acceptance testing
- **Phase 4: EVOLVE** - Continuous synchronization and drift detection

Replaces old stage-based system (0-ux through 6-maintenance) with clearer, more focused workflow.

#### MSL Format Adoption
- All specifications use MSL (Markdown Specification Language)
- Minimal format: title + frontmatter (criticality, failure_mode) + Requirements section
- [!] markers denote critical requirements
- Emphasis on "WHAT not HOW" - trust implementers for details

#### Metaspec System
- **base.spec.md** - Core requirements for all specifications
- **behavior.spec.md** - Observable outcome specifications
- **contract.spec.md** - Interface definition specifications
- **strategy.spec.md** - Cross-cutting technical decision specifications

Located in `.livespec/standard/metaspecs/`, these define the LiveSpec specification format itself.

#### Workspace/Product Separation
- **specs/workspace/** - HOW you build (process, portable to any project)
  - constitution.spec.md - Development principles
  - patterns.spec.md - Code and specification patterns
  - workflows.spec.md - Development workflows
- **specs/behaviors/** - WHAT system does (product-specific observable outcomes)
- **specs/contracts/** - Interfaces and contracts (APIs, data formats)
- **specs/strategy/** - Cross-cutting technical decisions (architecture, technology choices)

Clear separation prevents mixing portable methodology with product-specific specifications.

#### Template System
- Workspace templates for bootstrapping new projects
- Domain-specific templates (governance, operations)
- All templates follow MSL format
- Located in `.livespec/templates/`

#### Utility Prompts
- `utils/upgrade-methodology.md` - Safe methodology upgrades
- `utils/next-steps.md` - Workflow orchestration
- `utils/run-spike.md` - Discovery spike management
- `utils/analyze-failure.md` - Process failure analysis

Optional advanced prompts for complex scenarios.

#### Distribution Structure

```
dist/
├── AGENTS.md (new in unreleased)
├── .livespec-version.template (new in unreleased)
├── customizations.yaml.template (new in unreleased)
├── prompts/
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   ├── 4-evolve/
│   └── utils/
├── standard/
│   └── metaspecs/
└── templates/
    ├── workspace/
    ├── governance/ (new in unreleased)
    └── operations/ (new in unreleased)
```

Users copy `dist/` contents to `.livespec/` in their project.

#### Key Prompts

**Phase 0 (DEFINE):**
- 0a-setup-workspace.md
- 0b-define-problem.md
- 0c-identify-constraints.md

**Phase 1 (DESIGN):**
- 1a-design-architecture.md
- 1b-define-behaviors.md
- 1c-create-contracts.md

**Phase 2 (BUILD):**
- 2a-implement-from-specs.md
- 2b-create-tests.md

**Phase 3 (VERIFY):**
- 3a-run-validation.md
- 3b-acceptance-review.md

**Phase 4 (EVOLVE):**
- 4a-detect-drift.md
- 4b-extract-specs.md
- 4c-sync-complete.md
- 4d-regenerate-agents.md
- 4e-validate-extractions.md

### Removed

- Stage-based system (0-ux through 6-maintenance)
- Old reqs/ folder structure
- Stakeholder review templates (replaced with simpler acceptance review)
- UX-first templates (now general-purpose methodology)
- livespec-start.sh deployment script

### Breaking Changes

- Complete folder structure change (reqs/ → specs/)
- Specification format change (old templates → MSL format)
- Workflow change (stages → phases)
- No migration path from v0.2.0 (recommend fresh adoption)

---

## [0.2.0] - 2024-01-30

### Beta Release

LiveSpec is a living documentation framework that maintains synchronized specifications throughout the software lifecycle. This beta release provides a working system for bidirectional specification management, ready for early adopters and testing.

### Core Features

#### Documentation Management
- **Living Specifications** - Documentation that evolves with your code
- **Bidirectional Flow** - Create specs from ideas OR extract from code
- **Staged Workflow** - Clear progression through specification levels
- **Automatic Discovery** - Smart detection of what needs updating

#### UX-First Development
- User persona templates and workflows
- User journey mapping
- Information architecture documentation
- User success metrics tracking
- UX strategy documentation
- Interaction design tools
- Behavior specifications
- UI specifications
- Usability testing protocols

#### Stakeholder Review System
- **Workflow Orchestrator** - Intelligent guidance through the entire process
- **Review Gates** - Mandatory review points at key stages
- **Review Templates** - Structured feedback collection
- **Approval Tracking** - Complete audit trail
- **Feedback Integration** - Systematic incorporation of stakeholder input

#### Development Support
- **Test-Driven Development** - Built-in TDD support and validation
- **Rapid Prototyping** - Auto-build mode for quick experiments
- **Progress Tracking** - Comprehensive progress monitoring
- **Gap Analysis** - Identify missing documentation
- **Alignment Checking** - Ensure docs match code

#### Deployment System
- Easy installation via deployment scripts
- Framework configuration management
- Version tracking and migration support
- Helper scripts for common tasks
- Clean separation of framework and project files

### Documentation Structure

```
reqs/
├── 0-ux/             # UX documentation
├── 1-purpose/        # System purpose
├── 2-strategy/       # Technical strategy
├── 3-design/         # System design
├── 4-components/     # Component specs
├── 5-implementation/ # Implementation details
└── reviews/          # Stakeholder reviews
```

### Workflow Stages

1. **Stage 0** - Project Setup & UX Discovery
2. **Stage 1** - Discovery & Purpose
3. **Stage 2** - Strategy
4. **Stage 3** - Design
5. **Stage 4** - Components
6. **Stage 5** - Implementation
7. **Stage 6** - Maintenance

### Installation

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git

# Deploy to your project
./deploy-livespec.sh /path/to/your/project

# Start using
./livespec-start.sh
```

### Key Commands

- `0-orchestrate-workflow` - Start here for guidance
- `0a-setup-project` - Initialize new project
- `extract-specs-from-code` - Document existing code
- `align-specs-to-code` - Check synchronization
- `0d-prepare-stakeholder-review` - Prepare for reviews

### Requirements

- Claude Code CLI
- Markdown editor
- Git (recommended)

### Contributors

- Framework design and implementation
- Documentation and examples
- Testing and validation

---

**LiveSpec v0.2.0 (Beta)** - Specifications that live with your code.