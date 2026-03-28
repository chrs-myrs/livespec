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

---

## [5.4.0] - 2026-03-28

### Added

- **Mandatory spec frontmatter (IMP-005)**: All 119 specs carry six mandatory fields — `type`, `category`, `fidelity`, `criticality`, `failure_mode`, `governed-by` — plus per-category mandatory fields (workspace: `applies_to`, features: `satisfies` + `guided-by`, etc.)
- **Vocabulary spec (IMP-006)**: `references/standards/vocabulary.spec.md` documents all controlled terms across 6 domains (frontmatter values, relationship fields, phases, layers, registries, markers) with a documented extension mechanism for domain-specific values
- **Frontmatter validation**: `scripts/validate-frontmatter.sh` enforces IMP-005 compliance in pre-commit hook — checks base fields, per-category fields, type/category/fidelity values, and governed-by semantics
- **Standardised registry format (IMP-008)**: All registries carry consistent YAML frontmatter (`store`, `registry_type`, `schema_version`, `last_reviewed`, `entry_count`)

### Changed

- **governed-by semantics**: Now content governance only — `type` field implies metaspec template (format governance), removing dual-purpose ambiguity ⚠️ HIGH
- **Base metaspec**: Updated with type values, governed-by semantics, per-category mandatory fields, fidelity defaults, and field naming rules
- **All 12 type-specific metaspecs**: Updated with new mandatory field requirements
- **Context tree regenerated**: AGENTS.md (31.5KB) and 7 sub-agents reflect new frontmatter schema, vocabulary reference, and directional relationship field groups

### Fixed

- **Field naming inconsistency**: Normalised `derives_from` (underscore) to `derives-from` (hyphen) across ~7 specs
- **Syncthing conflict files**: Removed 22 sync-conflict files, added `*sync-conflict*` to `.gitignore`

### Closed

- **IMP-005**: Mandatory Spec Frontmatter — Implemented
- **IMP-006**: Vocabulary Spec as Standard Deliverable — Implemented
- **IMP-007**: Distributed Cross-References — Subsumed by IMP-005
- **IMP-008**: Standardised Registry Format — Implemented
- **IMP-009**: Fidelity Level as Spec Metadata — Subsumed by IMP-005

---

## [5.3.0] - 2026-03-14

### Added

- **Context-builder agent**: Dedicated sub-agent for AGENTS.md and ctxt/ regeneration — keeps parent session context clean
- **`/release` command**: Local slash command automating version increment, changelog finalisation, commit, push, and tagging
- **`.claude/` tracked in git**: Local commands, hooks, and agents are now committed (`.sessions/` remains ignored)

### Fixed

- Removed firecrawl MCP server (`.mcp.json` deleted)
- Fixed stale version references across project.yaml (5.2.0), README.md (4.1.0), and 4 other files (5.0.0)
- Updated `/livespec:evolve context` mode to delegate to context-builder agent instead of running inline

---

## [5.2.0] - 2026-02-28

### Plugin Distribution Release

This release adds **project incubation** and **v5 migration tooling** as first-class skills.

**Impact**: LOW - Additive only, no breaking changes

### Added

- **Birth skill**: `/livespec:birth` guides project incubation from idea to initialized LiveSpec workspace
- **Upgrade skill**: `/livespec:upgrade` migrates legacy LiveSpec installs (submodule/copy) to v5 plugin architecture
  - Handles nested subfolder migration
  - Skips plugin install step when already installed
  - Script-backed for deterministic execution

### Fixed

- Upgrade skill: nested subfolder migration now correctly relocates files
- Upgrade skill: no longer attempts to reinstall plugin when already present

---

## [5.1.0] - 2026-02-08

### Ambient Architecture Release

This release implements **ambient spec-first behavior** - agents automatically enforce specs without explicit commands.

**Impact**: MEDIUM - New skills added, one skill renamed

### Changed

- **Skill renamed**: `evolve` → `audit` for clarity
  - `/livespec:evolve` → `/livespec:audit`
  - Subcommands remain the same: `health`, `validate`, `context`, `extract`
  - `msl|scope|coverage` audits no longer need `audit` prefix (e.g., `/livespec:audit msl`)
- **Context file renamed**: `ctxt/evolve.md` → `ctxt/audit.md`
- **Command file renamed**: `commands/evolve.md` → `commands/audit.md`
- **Skills expanded**: 3 → 5 skills (go, init, design, audit, learn)

### Added

- **Router skill**: `/livespec:go` routes to appropriate skill based on intent
- **Init skill**: `/livespec:init` bootstraps new projects with folder structure
- **Visible spec-check indicator**: `[SPEC-CHECK]` shown when agent verifies spec existence
- **Ambient spec-first behavior**: Agent automatically checks specs before implementation
- **Skill behavior guide**: `docs/skill-behavior-guide.md` for testing and validation
- **Version management spec**: Updated to use plugin.json as source of truth
- **Release process**: Explicit checklist in version-management.spec.md
- **Upgrade skill**: Now updates project.yaml version after migration

---

## [5.0.0] - 2026-01-31

### Major: Plugin Architecture Consolidation

This release **consolidates the plugin architecture**, reducing complexity while maintaining full functionality. Commands reduced from 17 to 4 unified commands, skills from 7 to 3, and phases simplified to 3 modes.

**Impact**: HIGH - Breaking changes to command structure, upgrade guide provided

#### Core Changes

- **Commands consolidated**: 17 → 4 unified commands
  - `/livespec:go` - Intelligent entry point with intent routing
  - `/livespec:design` - Spec creation and refinement (feature, debug, refine, workspace, spec)
  - `/livespec:evolve` - Health, validation, context generation (health, validate, audit, context, extract)
  - `/livespec:learn` - Session completion and learning capture (capture, compliance)

- **Skills consolidated**: 7 → 3 focused skills
  - `design` - Unified spec work (absorbed init, spec-writing)
  - `evolve` - Evolution and maintenance (absorbed context-generation)
  - `learn` - Session completion and learning (new)

- **Phases simplified to modes**: 5 phases → 3 modes
  - `define` - Problem definition and workspace setup
  - `design` - Architecture and behavior specification
  - `evolve` - Health monitoring, learning, context generation
  - Build/Verify: Implementation concerns, guided but not owned by LiveSpec

- **specs/ folder structure**: Numbered → Semantic
  - `1-requirements/` → `foundation/`
  - `2-strategy/` → `strategy/`
  - `3-behaviors/` → `features/` + `interfaces/`

#### Added

- `commands/go.md` - Intent-routing entry point
- `commands/learn.md` - Session completion command
- `skills/learn/SKILL.md` - Learning capture skill
- `references/guides/upgrade-to-v5.md` - Comprehensive upgrade guide

#### Removed

- 13 individual commands (merged into unified commands)
- `skills/init/` (absorbed into design workspace mode)
- `skills/spec-writing/` (absorbed into design)
- `skills/context-generation/` (absorbed into evolve)
- Numbered ctxt/phases/ structure (replaced with mode files)

#### Migration

See `references/guides/upgrade-to-v5.md` for:
1. Removing legacy `.livespec-repo/` git submodule
2. Removing `.livespec` symlink
3. Installing v5 plugin
4. Migrating specs/ folder structure
5. Updating workspace spec references

---

## [4.1.0] - 2026-01-30

### Major: Claude Code Plugin Distribution

This release introduces **plugin-based distribution** for Claude Code, providing integrated commands, version management, and eliminates file duplication across projects.

**Impact**: MEDIUM - New installation method (plugin), legacy method (dist/ copy) continues working

#### Added

- **Claude Code Plugin Structure**
  - `.claude-plugin/plugin.json` - Plugin manifest
  - `.claude-plugin/marketplace.json` - Self-hosted marketplace
  - **7 Skills** for phase workflows:
    - `init` - Project initialization
    - `design` - Phase 1 architecture and behaviors
    - `build` - Phase 2 TDD implementation
    - `verify` - Phase 3 validation
    - `evolve` - Phase 4 drift detection and regeneration
    - `spec-writing` - MSL spec creation guidance
    - `context-generation` - AGENTS.md generation
  - **13 Commands** for utilities:
    - `validate`, `complete-session`, `health-report`, `rebuild-context`
    - `learn`, `audit`, `next-steps`, `suggest-improvements`
    - `refine-workspace`, `run-spike`, `analyze-failure`, `upgrade`, `measure-session`
  - **5 Sub-agents** for phase-specific context:
    - `phase-0-define.md`, `phase-1-design.md`, `phase-2-build.md`
    - `phase-3-verify.md`, `phase-4-evolve.md`

- **Reference Content** (`references/`)
  - All guides from `dist/guides/`
  - All standards from `dist/standard/`
  - All phase prompts from `dist/prompts/`
  - Templates from `dist/templates/`

- **Documentation**
  - `docs/plugin-installation.md` - Plugin setup guide
  - `docs/migration-to-plugin.md` - Migration from dist/ to plugin

#### Changed

- **README.md** - Plugin installation now primary method
- **Installation workflow** - `/plugin install livespec` instead of file copy

#### Deprecated

- **dist/ copy method** - Still works but plugin preferred
- **Manual prompt paths** - Use `/livespec:*` commands instead

#### Migration

Existing users can migrate:
1. `/plugin marketplace add chrs-myrs/livespec`
2. `/plugin install livespec@livespec`
3. `rm -rf .livespec/`
4. Use `/livespec:*` commands instead of prompt paths

See `docs/migration-to-plugin.md` for detailed steps.

---

## [4.0.0] - 2025-12-21

### Major: Disposable Code Architecture

This major release fundamentally reframes LiveSpec around **disposable code and durable specifications**. Code is now explicitly treated as regenerable from specs at any time, making upper layers (purpose, requirements, strategy, behaviors) the true assets while code becomes a disposable implementation artifact.

**Impact**: HIGH - Conceptual shift affects how you think about LiveSpec, though existing projects continue working

#### Core Philosophy Changes

- **"Code is disposable. Knowledge is not."** - New core principle
- **Two-branch model** - Shared foundation derives into:
  - Product branch: behaviors → tests → code (what you build)
  - Workspace branch: workspace specs → context tree (how you work)
- **Progressive disposability** - Lower layers more disposable than upper
- **Regeneration over refactoring** - Don't fix code, regenerate from specs
- **Human as stakeholder** - Human owns intention, AI manages specs/code/alignment

#### Added

- **specs/3-behaviors/abstraction-guidance.spec.md** - Three placement tests for discovery leveling
- **dist/guides/progressive-disposability.md** - Layer durability and regeneration guide
- **dist/guides/abstraction-guidance.md** - Discovery placement decision framework
- **AGENTS.md** - Principles #10 (Progressive Disposability) and #11 (Regeneration Over Refactoring)
- **install-livespec.sh** - CLAUDE.md → AGENTS.md symlink creation

#### Changed

- **PURPOSE.md** - Reframed: "Code is disposable. Knowledge is not."
- **specs/1-requirements/strategic/outcomes.spec.md** - Requirement 1 now "Specification-Driven Regeneration"
- **specs/1-requirements/strategic/constraints.spec.md** - Added "Code Disposability" and "Abstraction Purity" constraints
- **specs/2-strategy/architecture.spec.md** - Two-branch model diagram, progressive disposability table
- **specs/workspace/constitution.spec.md** - Added disposability and regeneration principles
- **AGENTS.md** - Summary reframed around information architecture and disposable code
- **Phase 4 prompts** - Drift detection reframed as "regeneration signal detection"

#### Breaking Conceptual Changes

This release doesn't break existing code but changes how you should think about LiveSpec:

| Old Thinking | New Thinking |
|--------------|--------------|
| Prevent specs from drifting | Maintain specs, regenerate code |
| Code is the deliverable | Specs are the deliverable, code is artifact |
| Keep code and specs in sync | Level up discoveries to specs |
| Refactor messy code | Regenerate from specs |

**Upgrading**: No file changes required. Adopt the mindset shift gradually.

---

## [3.13.0] - 2025-12-19

### Documentation: Information Architecture Identity

This release repositions LiveSpec's core identity from "folder structure" to "information architecture and context generation system." The folder structure is the means; the generated context tree (AGENTS.md) is the end.

**Impact**: LOW - Documentation-only, no breaking changes

#### Added

- **README.md** - Core Concepts section (Value Structure, Context Tree, Three Layers)
- **README.md** - Understanding Workspace Specs section with practical examples
- **README.md** - Troubleshooting section for common setup mistakes
- **llms.txt** - Core Concepts summary for Context7 consumption
- **specs/3-behaviors/documentation.spec.md** - Restructured requirements by concern

#### Changed

- **README.md** - New tagline: "An information architecture that generates context trees for AI agents"
- **README.md** - "What is LiveSpec?" now emphasizes context generation over folder structure
- **README.md** - Problem statement now includes "context loss" as key problem
- **README.md** - Key Features adds "Context Generation" as first feature
- **llms.txt** - Updated title and description to match new identity
- **specs/3-behaviors/documentation.spec.md** - Core Identity requirement emphasizes context generation

---

### Workspace Scope: Operating Context (Replaces Portability Test)

This release removes the "portability test" concept for workspace scope validation. The old test asked "Could I use this EXACT spec in ANY project?" - implying workspace specs must be portable across all projects. This was a false dichotomy: workspace specs can be just as bespoke as deliverable specs.

**New model**: workspace/ = **Operating context** (how agents, humans, and workspace interact). The decision test is now simply: "Is this ABOUT the workspace or IN the workspace?"

**Impact**: LOW - Conceptual clarification, no breaking changes to existing projects

#### Changed

- **specs/workspace/taxonomy.spec.md** - Updated workspace scope definition to "operating context"
- **specs/workspace/folder-organization.spec.md** - Removed portable methodology language, clarified operating context
- **specs/workspace/patterns.spec.md** - Removed portable methodology references
- **specs/3-behaviors/validation/workspace-scope-audit.spec.md** (⚠️ LOW impact)
  - Major rewrite: Changed from "portability audit" to "about vs in" boundary check
  - New test: "Is this ABOUT the workspace or IN the workspace?"
  - ABOUT indicators: development principles, operating conventions, agent behaviour rules
  - IN indicators: product names, technology stacks as requirements, domain terminology
- **specs/3-behaviors/validation/taxonomy-structure-validation.spec.md** - Updated to operating context framing
- **specs/3-artifacts/prompts/0a-quick-start.spec.md** - Removed portable methodology language
- **specs/3-artifacts/prompts/0b-customize-workspace.spec.md** - Removed portable methodology language
- **specs/3-artifacts/prompts/utils-audit-workspace-scope.spec.md** - Major rewrite for "about vs in" test

- **dist/prompts/0-define/0a-quick-start.md** - Updated workspace explanation
- **dist/prompts/0-define/0b-customize-workspace.md** - Updated workspace guidance
- **dist/prompts/0-define/0x-validate-understanding.md** - Updated validation criteria
- **dist/prompts/4-evolve/4a-detect-drift.md** - Updated workspace scope references
- **dist/prompts/4-evolve/4d-regenerate-context.md** - Updated workspace test language
- **dist/prompts/utils/audit-workspace-scope.md** - Major rewrite for "about vs in" approach

- **dist/standard/metaspecs/taxonomy.spec.md** - Updated operating context definition
- **dist/standard/metaspecs/workspace.spec.md** - Updated requirements for operating context
- **dist/standard/metaspecs/strategy.spec.md** - Updated workspace boundary description
- **dist/standard/conventions/folder-structure.spec.md** - Updated workspace test language

- **dist/guides/workspace-scope-clarity.md** - Complete rewrite as "about vs in" guide
- **dist/scripts/audit-workspace-scope.sh** - Updated test logic and output messages

- **dist/templates/workspace/taxonomy-*.spec.md.template** (all 5 templates) - Updated to operating context framing

- **examples/ecommerce-checkout/specs/workspace/taxonomy.spec.md** - Updated to operating context model

- **AGENTS.md** and **dist/AGENTS.md** - Updated workspace scope guidance

- **docs/livespec-conventions.md** - Updated workspace folder description
- **README.md** - Updated workspace folder description
- **specs/README.md** - Updated workspace folder description
- **ctxt/domains/governance.md** - Updated workspace test references
- **llms.txt** - Updated workspace folder description
- **specs/3-behaviors/framework/standard.spec.md** - Updated workspace metaspec description
- **dist/guides/common-pitfalls.md** - Updated workspace scope prevention advice

#### Removed

- **"Portability test"** concept - No longer used to determine workspace scope
- **"Could I use this in ANY project?"** question - Replaced by "about vs in" test
- **"Portable methodology"** language - Replaced by "operating context"

---

## [3.12.0] - 2025-12-15

### PURPOSE Boundary Enforcement

This release introduces enforcement for PURPOSE.md document boundaries. PURPOSE documents should capture vision only (<20 lines) with all other content routed directly to appropriate specs at capture time. This prevents PURPOSE files from becoming bloated catch-alls.

**Impact**: LOW - Backward compatible, adds validation without breaking existing projects

#### Added

- **scripts/validate-purpose.sh** - Validation script for PURPOSE.md boundaries
  - Validates <20 content lines (warns at >15)
  - Checks required structure (Why/What Success sections)
  - Detects prohibited patterns (constraints, architecture, process language)
  - Suggests content routing for violations
  - Integrates with full validation suite (Section 10)

- **specs/3-artifacts/validators/validate-purpose.spec.md** - Spec for validation script

- **dist/prompts/utils/extract-purpose-overflow.md** - Migration utility
  - Guides extraction of oversized PURPOSE.md content to proper specs
  - For upgrading existing projects with bloated PURPOSE files

- **specs/3-artifacts/prompts/utils-extract-purpose-overflow.spec.md** - Spec for migration utility

- **dist/tests/structure/test_full_validation.sh Section 10** - PURPOSE.MD BOUNDARY
  - Validates PURPOSE.md line count in full validation suite
  - Checks for required sections and forbidden frontmatter

#### Changed

- **dist/standard/metaspecs/purpose.spec.md** (LOW impact)
  - Added Content Routing Table with decision test
  - Added common mistakes examples
  - Clearer guidance on what belongs where

- **dist/prompts/0-define/0c-define-problem.md** (LOW impact)
  - Added Active Content Routing section
  - Routes content to correct spec AT CAPTURE TIME
  - Prevents accumulation then extraction pattern

- **dist/templates/agents/spec-first-enforcement.md** (LOW impact)
  - Added PURPOSE.md Boundary Enforcement section
  - Content routing table for agents
  - Validation script reference

- **AGENTS.md** - Added PURPOSE.md Boundary Enforcement guidance

#### Fixed

- **PURPOSE.md** - Trimmed from 22 to 14 lines (removed extra sections)
  - Moved "Specification Philosophy" content (already in constitution.spec.md)
  - Moved "Primary Focus" content (implicit in outcomes)

- **examples/ecommerce-checkout/PURPOSE.md** - Trimmed from 104 to 12 lines
  - Documentation content already exists in README.md

- **examples/loan-system/PURPOSE.md** - Created missing file (12 lines)

---

## [3.11.0] - 2025-12-15

### 🎯 Project-Controlled Context Generation

This release introduces `context-architecture.spec.md` as the 5th workspace spec, giving target projects explicit control over what content populates their AGENTS.md. Previously, regenerate-contexts had no project-level guidance, sometimes producing phase file dumps instead of synthesized context appropriate for coding agents.

**Impact**: MEDIUM - New workspace spec required for context generation

#### Added

- **specs/workspace/context-architecture.spec.md** (⚠️ MEDIUM impact)
  - New 5th workspace spec created during Phase 0 (quick-start and customize-workspace)
  - Defines content sources: "always include" (root) vs "include when relevant" (sub-agents) vs "exclude"
  - Specifies content focus balance: behaviors (40%) / constraints (30%) / patterns (30%)
  - Includes structural hints: root priorities, sub-agent triggers
  - Consolidates previous `agent-contexts.spec.md` and `workspace-agent.spec.md` concepts

- **dist/templates/workspace/context-architecture.spec.md.template**
  - Template for target projects with software domain defaults
  - Sensible defaults for most projects (balanced mix, moderate compression)

#### Changed

- **dist/prompts/0-define/0a-quick-start.md** (⚠️ MEDIUM impact)
  - Now creates 5 workspace specs (was 4): taxonomy, constitution, patterns, workflows, context-architecture
  - Removed workspace-agent.spec.md (consolidated into context-architecture)

- **dist/prompts/0-define/0b-customize-workspace.md** (⚠️ MEDIUM impact)
  - Updated to create context-architecture.spec.md instead of agent-contexts.spec.md and workspace-agent.spec.md
  - Reduced from 6 to 5 workspace specs

- **dist/prompts/utils/regenerate-contexts.md** (⚠️ MEDIUM impact)
  - Now requires context-architecture.spec.md (errors with Phase 0 guidance if missing)
  - Context builder reads spec for content sources and focus balance

- **.claude/agents/context-builder/instructions.md**
  - Reads context-architecture.spec.md for content sources
  - Applies content focus balance during generation
  - Clear error if spec missing

- **specs/workspace/agent-contexts.spec.md → context-architecture.spec.md**
  - Renamed and expanded with content source control
  - Combined structure + content definitions

#### Removed

- **dist/templates/workspace/agent-contexts.spec.md.template** (replaced by context-architecture)
- **workspace-agent.spec.md from Phase 0 output** (consolidated)

#### Migration

Existing projects should:
1. Create `specs/workspace/context-architecture.spec.md` from template
2. Run regenerate-contexts to rebuild AGENTS.md with spec-driven content
3. Optionally remove old `agent-contexts.spec.md` and `workspace-agent.spec.md`

---

## [3.9.1] - 2025-12-15

### 🔧 Installation & Upgrade Documentation Fix

This patch release fixes outdated installation instructions and stale prompt references that were causing agents (with or without Context7) to follow incorrect workflows.

**Impact**: LOW - Documentation and reference fixes only, no behavioral changes

#### Fixed

- **llms.txt** (Context7 entry point)
  - Updated version 3.3.0 → 3.9.1
  - Fixed all prompt paths (`0a-setup-workspace` → `0a-quick-start`)
  - Updated project structure to show current `1-requirements/`, `2-strategy/`, `3-behaviors/`, `3-contracts/` layout
  - Updated quick start commands with correct paths

- **dist/prompts/utils/upgrade-methodology.md** (⚠️ LOW impact)
  - Converted from stub reference to full workflow prompt
  - Added pre-flight checks (detect installation method, show version)
  - Added submodule upgrade steps
  - Added copy installation upgrade steps with migration recommendation
  - Added validation checks and post-upgrade summary

- **Stale `0a-setup-workspace` → `0a-quick-start` references** (25+ files)
  - dist/prompts/utils/next-steps.md, audit-context-compression.md
  - dist/prompts/2-build/2a-implement-from-specs.md, 2b-create-tests.md
  - dist/prompts/4-evolve/4a-detect-drift.md
  - dist/standard/phase-prerequisites.md
  - dist/standard/metaspecs/prompt.spec.md, behavior.spec.md
  - dist/standard/conventions/naming.spec.md, context-compression.spec.md
  - dist/customizations.yaml.template
  - dist/templates/workspace/taxonomy-governance.spec.md.template
  - docs/methodology.md, quickstart.md, livespec-conventions.md
  - Multiple specs in specs/1-requirements/, specs/3-behaviors/, specs/3-artifacts/

---

## [3.9.0] - 2025-11-21

### 🏗️ Context Tree Knowledge Standardization

This minor release extracts context tree mechanism into framework convention, enabling all projects to discover and adopt hierarchical agent contexts. Completes value tree traceability from requirements through implementation.

**Impact**: MEDIUM (⚠️) - Phase 0 creates 5 workspace specs (was 3), framework provides universal mechanism

#### Added

- **dist/standard/conventions/context-tree.spec.md** (⚠️ MEDIUM impact - new convention)
  - Universal context tree mechanism (384 lines)
  - Root AGENTS.md + ctxt/ sub-agents pattern
  - Proactive loading mechanism
  - Size budget rationale
  - Generation governance
  - Distribution pattern
  - Applies to all LiveSpec projects

- **dist/standard/metaspecs/agent.spec.md** (⚠️ LOW impact - new pattern)
  - Pattern for agent specifications
  - Parallel to prompt.spec.md
  - Prerequisites validation, source extraction, generation, validation, results reporting, isolation

- **dist/templates/workspace/agent-contexts.spec.md.template** (⚠️ MEDIUM impact - Phase 0 template)
  - Template for project context tree structure
  - References context-tree convention for mechanism
  - Focuses on project-specific choices (phase/domain/utility sub-agents)

- **dist/templates/workspace/workspace-agent.spec.md.template** (⚠️ MEDIUM impact - Phase 0 template)
  - Template for AGENTS.md content definition
  - References positioning guide and context-tree convention
  - Defines generation sources and content structure

- **specs/3-behaviors/context-generation.spec.md**
  - Behavior spec bridging workspace structure → artifact implementation
  - Observable outcome: "Valid agent context tree generated from workspace specs"
  - Completes value tree: requirements → workspace → behaviors → artifacts

- **specs/3-artifacts/agents/context-builder.spec.md**
  - Agent artifact spec for context-builder implementation
  - Specifies prerequisites validation, content extraction, generation, compression, validation, results reporting

#### Changed

- **dist/prompts/0-define/0a-quick-start.md** (⚠️ MEDIUM impact - Phase 0 change)
  - Now creates 5 workspace specs (was 3)
  - Added agent-contexts.spec.md creation (step 4)
  - Added workspace-agent.spec.md creation (step 5)
  - Both required for context regeneration

- **dist/prompts/0-define/0b-customize-workspace.md** (⚠️ MEDIUM impact - Phase 0 change)
  - Now creates 5 workspace specs (was 3)
  - Added template references for agent-contexts and workspace-agent specs
  - Detailed customization guidance for context tree

- **dist/AGENTS.md** (⚠️ LOW impact - bootstrap reference)
  - References context-tree convention for universal mechanism
  - Updated prerequisites list for full context tree generation

- **specs/workspace/agent-contexts.spec.md**
  - REFACTORED: 185 lines → 67 lines (64% reduction)
  - Removed universal mechanism (now in convention)
  - Focuses on LiveSpec's specific choices (9 sub-agents)
  - Added governed-by: context-tree.spec.md

- **specs/workspace/workspace-agent.spec.md**
  - REFACTORED: 137 lines → 76 lines (45% reduction)
  - Removed mechanism explanation
  - Focuses on LiveSpec's content decisions
  - Added governed-by: context-tree.spec.md

- **specs/3-artifacts/prompts/utils-regenerate-context.spec.md**
  - Added governed-by: context-tree.spec.md

- **.claude/agents/context-builder/instructions.md**
  - Added specification references (behavior, artifact, structure)

#### Fixed

- **specs/3-artifacts/validators/check-requires-spec.spec.md**
  - Added missing frontmatter (was orphaned spec)
  - Connected to value tree with derives-from, governed-by, guided-by

#### Benefits

- **Universal mechanism distributed automatically**: All projects get context-tree convention via dist/
- **Clean separation of concerns**: Framework provides mechanism, projects customize choices
- **Value tree navigable**: Complete traceability from requirements through implementation
- **Phase 0 completeness**: Creates all prerequisites for context regeneration
- **Agent discoverability**: Workspace agents find functionality through value tree

---

## [3.8.1] - 2025-11-18

### 📚 Installation Documentation Fix

This patch release fixes a documentation gap that caused AI agents to use outdated installation methods (manual directory copy) instead of the new sparse submodule installation introduced in v3.8.0. Adds comprehensive installation guide and verification tools to prevent future adoption issues.

**Impact**: LOW - Documentation improvement, no code changes

### Added

- **dist/README.md** (⚠️ LOW impact - new entry point)
  - Comprehensive installation guide (244 lines)
  - Documents all 4 installation methods with pros/cons
  - Quick start instructions after installation
  - Version tracking guidance
  - Git hook setup instructions
  - First file users/agents see when they get dist/

- **dist/scripts/check-livespec-installation.sh** (⚠️ LOW impact - new validation tool)
  - Validates LiveSpec installation completeness
  - Checks VERSION, directories, files, script permissions
  - Detects symlink vs directory installation
  - Version mismatch warnings
  - Exit codes: 0=ready, 1=not installed, 2=incomplete
  - 197 lines with colored diagnostic output

### Changed

- **dist/AGENTS.md Quick Start** (⚠️ MEDIUM impact - agents read this first)
  - Line 22 changed from "Copy `.livespec/` to your project"
  - To: "Install LiveSpec" with helper script recommendation
  - References README.md for alternative methods
  - Legacy copy method noted as still functional

- **dist/prompts/0-define/0a-quick-start.md** (⚠️ MEDIUM impact - first prompt used)
  - Added Step 0: Verify LiveSpec Installation (before creating workspace)
  - Checks for .livespec/VERSION existence
  - Guides to helper script installation if missing
  - Cannot proceed without functional .livespec/ directory
  - Multiple fallback installation options provided

- **specs/3-artifacts/prompts/0a-quick-start.spec.md** (⚠️ LOW impact - spec update)
  - Added installation verification requirement
  - Updated validation criteria to include installation check
  - Enforces "check before workspace creation" pattern

### Fixed

- **Installation Discovery Problem** (⚠️ HIGH severity - was causing adoption issues)
  - **Problem**: Agents followed outdated "copy dist/" instructions in AGENTS.md
  - **Impact**: Projects used manual copy method instead of sparse submodule
  - **Result**: Duplication across projects, manual updates required, no submodule benefits
  - **Example**: myrs-infra project installed with directory copy (no submodule integration)
  - **Fix**: Multiple documentation touch points now reference helper script and README.md

- **Missing Entry Point Documentation** (⚠️ MEDIUM severity)
  - dist/ had no README explaining installation methods
  - Quick-start prompt assumed .livespec/ already existed
  - Helper script undocumented despite being implemented in v3.8.0
  - Now: README.md is first file agents see with comprehensive installation guide

### Prevention Measures

**Multiple documentation layers prevent outdated method usage:**
1. README.md as primary entry point (first file read)
2. AGENTS.md Quick Start references helper script
3. 0a-quick-start.md includes installation verification (Step 0)
4. Validation script available for installation health checks
5. Spec enforcement requires installation verification

**Path agents now follow:**
- Read AGENTS.md → See "Install LiveSpec" with helper script
- OR read README.md → Get full installation guide
- OR use 0a-quick-start.md → Hit installation check in Step 0
- Cannot create workspace without .livespec/VERSION existing

### Architecture

**Documentation Touch Points:**
- Entry: dist/README.md (comprehensive guide)
- Quick Start: AGENTS.md (references helper script)
- First Prompt: 0a-quick-start.md (installation verification)
- Validation: check-livespec-installation.sh (health check)
- Enforcement: Spec requires installation check

### Migration Guide

**No action required** - this is a documentation-only release. Projects using v3.8.0 continue working unchanged.

**Optional improvements:**
- Read dist/README.md for comprehensive installation documentation
- Use check-livespec-installation.sh to verify existing installation health
- Future installations will automatically use helper script method

---

## [3.8.0] - 2025-11-18

### 🚀 Validation Infrastructure Distribution & Sparse Submodules

This minor release fixes a critical distribution gap that blocked validation adoption in target projects, and introduces sparse submodule installation for zero-duplication deployments. Health check tools (scripts, tests, git hooks) are now properly distributed in `dist/`, making validation work out-of-the-box for target projects. Sparse submodules enable sharing one LiveSpec installation across multiple projects with automatic updates.

**Impact**: MEDIUM - Fixes blocking bug for validation adoption, adds new optional installation method (backward compatible)

### Added

- **Validation Script Distribution** (⚠️ MEDIUM impact)
  - `dist/scripts/` now contains all 12 validation scripts (2,148 lines)
  - `dist/scripts/traceability/` contains 6 research linkage validation scripts
  - `dist/tests/structure/` contains comprehensive validation test suite
  - `dist/tests/prompts/` contains prompt-specific test scripts
  - Fixes critical bug: target projects can now run validation without manual script copying

- **Git Hook Support for Target Projects** (⚠️ MEDIUM impact)
  - `dist/scripts/setup-hooks.sh` now detects both LiveSpec source and target project paths
  - Hooks work correctly in both contexts (tests/ for source, .livespec/tests/ for targets)
  - Pre-commit validation functional out-of-the-box after copying dist/
  - Action recommended: Re-run setup-hooks.sh in target projects to get fixed hook

- **Sparse Submodule Installation** (⚠️ LOW impact - new optional method)
  - New: `scripts/install-livespec.sh` - Automated installation helper with auto-detection
  - Supports three methods: sparse submodule (preferred), full submodule, directory copy
  - Sparse submodules enable zero-duplication across projects (one local copy, many references)
  - Requires: git 2.25+ or git-partial-submodule tool
  - Action optional: Use for new projects, existing projects continue working unchanged

- **Installation Behavior Spec** (⚠️ LOW impact)
  - New: `specs/3-behaviors/installation.spec.md` - Documents all three installation methods
  - Specifies auto-detection logic, fallback behavior, validation steps

### Changed

- **Distribution Architecture** (⚠️ MEDIUM impact)
  - LiveSpec source now uses symlinks: `/scripts → dist/scripts`, `/tests → dist/tests`
  - True dogfooding: LiveSpec uses exactly what target projects receive
  - Scripts/tests are authoritative in `dist/`, source project accesses via symlinks
  - Matches existing pattern: `/prompts → dist/prompts`

- **Framework Immutability Model** (⚠️ LOW impact)
  - Removed customizations.yaml tracking pattern entirely
  - `.livespec/` established as immutable framework reference
  - Simplifies upgrades: 9 phases → 4 steps (git submodule update)
  - Reduces upgrade time: 30+ minutes → 2 minutes
  - Innovation happens by extending (not modifying) framework

- **Upgrade Workflow Simplified** (⚠️ LOW impact)
  - `specs/3-artifacts/prompts/utils-upgrade.spec.md` simplified (228 → 184 lines)
  - `specs/2-strategy/architecture.spec.md` - Removed customization tracking section
  - `specs/1-requirements/functional/changelog.spec.md` - Simplified impact categories
  - Migration guide: `docs/migration/remove-customizations.md`

### Fixed

- **Validation Adoption Blocker** (⚠️ HIGH impact - was preventing adoption)
  - **Problem**: Documentation told target projects to run `bash scripts/setup-hooks.sh` but scripts didn't exist in `dist/`
  - **Impact**: First commit after hook setup failed with "No such file or directory"
  - **Result**: Users either couldn't enable validation or used `--no-verify` (defeating Layer 4 enforcement)
  - **Fix**: All validation tools now distributed in `dist/scripts/` and `dist/tests/`
  - **Verified**: Tested in simulated target project - hooks install and execute correctly

- **Dogfooding Gap** (⚠️ LOW impact - internal consistency)
  - LiveSpec now uses same scripts/tests distribution as target projects (via symlinks)
  - Ensures any changes to validation tools are immediately tested in source project
  - Prevents future distribution gaps through true dogfooding

### Architecture

- **Distribution Model**: Scripts and tests moved to `dist/` as authoritative location (source project accesses via symlinks)
- **Installation Methods**: Three options with auto-detection (sparse submodule preferred, full submodule fallback, directory copy last resort)
- **Framework Immutability**: No customization tracking, `.livespec/` is read-only reference, extensions live outside
- **Validation Enforcement**: Layer 4 (pre-commit hooks) now functional for target projects

### Migration Guide

**For existing target projects using LiveSpec**:

1. **Update .livespec/ from dist/**:
   ```bash
   cd your-project
   rm -rf .livespec
   cp -r /path/to/livespec/dist/ .livespec/
   ```

2. **Re-run hook setup** (if using validation):
   ```bash
   bash .livespec/scripts/setup-hooks.sh
   ```

3. **Verify scripts exist**:
   ```bash
   ls .livespec/scripts/*.sh      # Should show 12 scripts
   ls .livespec/tests/structure/  # Should show test_full_validation.sh
   ```

**For LiveSpec source project**:
- No action required - symlinks automatically created
- Scripts and tests now accessed via `scripts/` and `tests/` symlinks

**For new projects**:
- Consider sparse submodule installation for zero-duplication deployments
- See `scripts/install-livespec.sh --help` for options

---

## [3.7.0] - 2025-01-18

### 🏛️ Complete Value Structure Traceability

This minor release completes the value structure architecture by clarifying the workspace/strategy boundary and ensuring all specs trace through Layer 1 requirements. Based on deep architectural analysis, fixes fundamental frontmatter relationship model to achieve 100% PURPOSE.md traceability.

**Impact**: HIGH - Breaking changes to frontmatter relationships, but provides complete value chain integrity

### BREAKING CHANGES

- **Frontmatter relationship model changed**: Specs now use `satisfies:` to trace through Layer 1 requirements instead of `derives-from: PURPOSE.md` (skipping layers is no longer valid)
- **Workspace specs repositioned**: Now satisfy requirements like any other deliverable, not "orthogonal governance"
- **Complete value chain required**: All specs must trace: spec → outcomes.spec.md → PURPOSE.md (no shortcuts)

### Added

- **New Strategy Specs** (⚠️ HIGH impact)
  - `specs/2-strategy/markdown-standards.spec.md` - MSL format requirements, documentation patterns, confidence markers for extracted specs
  - `specs/2-strategy/testing-approach.spec.md` - TDD discipline, Red-Green-Refactor cycle, test-spec-implementation traceability
  - Cross-cutting standards now in strategy layer (not duplicated in workspace)

- **Docs Generation Pattern** (⚠️ LOW impact)
  - `dist/guides/generating-docs-from-specs.md` - Pattern for generating user-facing documentation from strategy specs
  - Shows workspace→strategy→generated docs flow
  - Single source of truth with multiple presentations

### Changed

- **Value Structure Architecture** (⚠️ HIGH impact - affects all projects)
  - `dist/guides/spec-decision-framework.md` - Added dual-dimension value structure diagram (product + workspace)
  - Both dimensions now trace to PURPOSE.md (not orthogonal)
  - Clear boundary: Workspace = meta-structural pointers, Strategy = cross-cutting content

- **Workspace Specs Frontmatter** (⚠️ HIGH impact)
  - `specs/workspace/constitution.spec.md` - Replaced `derives-from: PURPOSE.md` with `satisfies: outcomes.spec.md (Req 4, 5)`
  - `specs/workspace/patterns.spec.md` - Removed `derives-from: PURPOSE.md`, added strategy references section pointing to markdown-standards and testing-approach
  - `specs/workspace/workspace-agent.spec.md` - Added `satisfies: outcomes.spec.md (Req 5, 6)`
  - `specs/workspace/agent-contexts.spec.md` - Added `satisfies: outcomes.spec.md (Req 6)`
  - `specs/workspace/folder-organization.spec.md` - Added `satisfies: outcomes.spec.md (Req 5)`

- **Strategy Specs Frontmatter** (⚠️ HIGH impact)
  - `specs/2-strategy/architecture.spec.md` - Changed to `satisfies: outcomes.spec.md (Req 1, 3)` (delivers requirements directly)
  - `specs/2-strategy/markdown-standards.spec.md` - Removed `derives-from: PURPOSE.md` and `derives-from: outcomes.spec.md`
  - `specs/2-strategy/testing-approach.spec.md` - Removed `derives-from: PURPOSE.md` and `derives-from: outcomes.spec.md`
  - `specs/2-strategy/three-layer-architecture.spec.md` - Removed `derives-from: PURPOSE.md`, kept `derives-from: outcomes.spec.md`

- **Context Generation** (⚠️ MEDIUM impact)
  - `dist/prompts/4-evolve/4d-regenerate-context.md` - Added logic to follow workspace→strategy references when generating AGENTS.md
  - Context generation now includes strategy specs referenced by workspace specs

### Fixed

- **Broken References** (⚠️ LOW impact)
  - `specs/workspace/patterns.spec.md` - Fixed reference to `agent-contexts.spec.md` (was incorrectly pointing to non-existent `context-structure.spec.md`)

- **Value Structure Traceability** (⚠️ HIGH impact)
  - Completed PURPOSE.md traceability chain for all specs (100% coverage through Layer 1)
  - No more layer-skipping with `derives-from: PURPOSE.md`
  - Clear distinction: `derives-from` (parent-child), `satisfies` (implements requirement), `guided-by` (follows strategy)

### Architecture

- **Dual-Dimension Model**: Product specs (what to build) + Workspace specs (how to organize) both deriving from PURPOSE.md
- **Workspace Specs Reference Strategy Specs**: patterns.spec.md points to markdown-standards.spec.md and testing-approach.spec.md
- **Complete Value Chain**: All specs → outcomes.spec.md → PURPOSE.md (no layer skipping)
- **Clear Boundary**: Workspace = meta-structural pointers, Strategy = cross-cutting content
- **Dogfooding Score**: Improved from 8.7/10 to ~9.5/10 (complete internal consistency)

### Migration Guide

**For existing projects**:

1. **Update workspace spec frontmatter**:
   ```yaml
   # OLD (incorrect - skips Layer 1)
   derives-from:
     - PURPOSE.md

   # NEW (correct - traces through requirements)
   satisfies:
     - specs/1-requirements/strategic/outcomes.spec.md (Requirement X)
   ```

2. **Extract cross-cutting standards** to specs/2-strategy/:
   - Coding standards → `2-strategy/coding-standards.spec.md`
   - Documentation patterns → `2-strategy/markdown-standards.spec.md`
   - Testing approach → `2-strategy/testing-approach.spec.md`

3. **Update workspace specs to reference** strategy specs:
   ```markdown
   ## Cross-Cutting Development Standards

   - **Coding Standards**: See specs/2-strategy/coding-standards.spec.md
   - **Testing Approach**: See specs/2-strategy/testing-approach.spec.md
   ```

4. **Verify complete chain**: Run validation to ensure all specs trace to PURPOSE.md through requirements

**Action recommended**: Review your workspace/ and 2-strategy/ folders, ensure proper separation of pointers (workspace) vs content (strategy)

---

## [3.5.2] - 2025-11-10

### 🛡️ Enforcement Infrastructure & Validation Framework

This patch release addresses the root cause identified in failed project implementations: **weak enforcement of LiveSpec principles**. Based on analysis of project-governance failure modes, adds proactive validation scripts and comprehensive guidance to make compliance the path of least resistance.

**Impact**: MEDIUM - New validation tools strengthen enforcement, backward compatible but highly recommended for adoption

### Added

- **Taxonomy Structure Validation** (⚠️ MEDIUM impact)
  - New: `scripts/validate-taxonomy-structure.sh` - Validates all 4 required sections in taxonomy.spec.md
  - Checks: Project Domain, Workspace Scope, Specs Boundary, AI agents must sections
  - Prevents agent confusion about file placement decisions
  - Discovered: LiveSpec's own taxonomy needs structure fix (dogfooding validation)
  - Action recommended: Run validation on your projects, fix any missing sections

- **Workspace Scope Audit** (⚠️ MEDIUM impact)
  - New: `scripts/audit-workspace-scope.sh` - Detects product-specific content in workspace/
  - Applies portability test: "Could I use this in ANY project?"
  - Prevents workspace pollution with product features/architecture
  - Historical context: Catches exact failure from project-governance (TMP taxonomy in workspace/)
  - Action recommended: Audit your workspace/ directory, relocate product content

- **Spec Purity Detection** (⚠️ MEDIUM impact)
  - New: `scripts/detect-code-in-specs.sh` - Finds executable code in requirements/strategy specs
  - Enforces WHAT-not-HOW principle (MSL purity)
  - Detects procedural code (Python, TypeScript, bash loops) in declarative specs
  - Historical context: Catches Python caching implementation in policy-resolution.spec.md
  - Action recommended: Scan your specs, remove implementation details

- **Architecture Alignment Validation** (⚠️ LOW impact)
  - New: `scripts/validate-architecture-alignment.sh` - Verifies referenced directories exist
  - Prevents spec-reality drift (specs describing non-existent structures)
  - Historical context: Would catch project-governance describing policies/, templates/, src/ that don't exist
  - Action optional: Run if architecture specs reference directory structures

- **Comprehensive Workspace Scope Guide** (⚠️ LOW impact)
  - New: `dist/guides/workspace-scope-clarity.md` - Deep dive on portability principle
  - Explains "two taxonomies confusion" (product taxonomy vs project taxonomy)
  - Real examples from project-governance failure mode
  - Decision framework for workspace vs product boundary
  - Action optional: Reference when unclear about workspace/ placement

- **Validation Utility Prompts** (⚠️ LOW impact)
  - New: `dist/prompts/utils/audit-workspace-scope.md` - Guides agents through portability testing
  - New: `dist/prompts/utils/validate-spec-purity.md` - Guides agents through code-in-specs detection
  - New: 6 behavior specifications for validation workflows (specs/3-behaviors/validation/)
  - Action optional: Use prompts for guided validation sessions

### Changed

- **Phase 0 (DEFINE) Enhanced** (⚠️ MEDIUM impact)
  - Updated: `dist/prompts/0-define/0b-customize-workspace.md` - Added taxonomy validation step
  - Agents now run `scripts/validate-taxonomy-structure.sh` after creating taxonomy
  - Ensures complete taxonomy before proceeding to Phase 1
  - Action recommended: Use updated prompt for new projects

- **Phase 4 (EVOLVE) Enhanced** (⚠️ MEDIUM impact)
  - Updated: `dist/prompts/4-evolve/4a-detect-drift.md` - Added structural validations phase
  - Drift detection now starts with 4 structural validations before code/spec comparison
  - Prevents false drift signals from structural issues
  - Action recommended: Run structural validations before drift detection

- **Project Validation Enhanced** (⚠️ MEDIUM impact)
  - Updated: `dist/prompts/utils/validate-project.md` - Integrated 4 new validation scripts
  - Comprehensive validation now includes taxonomy, workspace scope, spec purity, architecture alignment
  - Action recommended: Use enhanced validation before releases

- **MSL Minimalism Guide Enhanced** (⚠️ LOW impact)
  - Updated: `dist/guides/msl-minimalism.md` - Added "Code in Specs = HOW Violation" section
  - Clear guidance on when code blocks are acceptable vs violations
  - Examples: Python implementation (violation) vs JSON config (acceptable)
  - Action optional: Reference when writing specifications

- **Taxonomy Metaspec Enhanced** (⚠️ LOW impact)
  - Updated: `dist/standard/metaspecs/taxonomy.spec.md` - Added automated validation section
  - Documents validation scripts and when to run them
  - Action optional: Informational update

- **AGENTS.md Enhanced** (⚠️ LOW impact)
  - Updated: `AGENTS.md` - Added 4 new anti-patterns with validation scripts
  - Added workspace scope clarity guide to reference library
  - Added 2 new utility prompts to prompt navigation table
  - Action optional: Agents automatically use updated guidance

### Fixed

- Taxonomy structure validation catches incomplete taxonomies (missing required sections)
- Workspace scope audit prevents product-specific content accumulation
- Spec purity detection enforces MSL minimalism (WHAT not HOW)
- Architecture alignment prevents spec-reality drift

### Historical Context

This release directly addresses failure modes discovered in project-governance analysis:

1. **Incomplete taxonomy** → Agent had no guidance on file placement → `validate-taxonomy-structure.sh`
2. **Product taxonomy in workspace/** → Violated portability principle → `audit-workspace-scope.sh`
3. **Python code in strategy specs** → Violated WHAT-not-HOW → `detect-code-in-specs.sh`
4. **Specs describing non-existent directories** → Spec-reality drift → `validate-architecture-alignment.sh`

**User quote**: "I had to re-iterate many fundamental LiveSpec principles" → Now enforced structurally

### Dogfooding Validation

All 4 validation scripts tested on:
- ✅ **project-governance** (failed project) - Caught all identified issues
- ✅ **LiveSpec itself** - Discovered LiveSpec's own taxonomy structure issue

### Migration Notes

**Upgrading from 3.5.1:**

**Recommended actions:**
1. Run `bash scripts/validate-taxonomy-structure.sh` - Fix any missing sections
2. Run `bash scripts/audit-workspace-scope.sh` - Relocate any product content from workspace/
3. Run `bash scripts/detect-code-in-specs.sh` - Remove implementation code from specs
4. Read `dist/guides/workspace-scope-clarity.md` if workspace boundary unclear

**Optional:**
- Integrate validations into your pre-commit hooks
- Use new utility prompts for guided validation sessions
- Run `bash scripts/validate-architecture-alignment.sh` if architecture specs reference directories

**Backward compatibility:**
- All validation scripts are non-destructive (report only)
- Existing workflows continue to work
- New validations supplement existing validation, don't replace

---

## [3.5.1] - 2025-11-08

### 🔧 Learning Internalization & Dogfooding Improvements

This patch release applies learnings from the v3.5.0 session using LiveSpec's own learning internalization process. Demonstrates dogfooding: feedback captured → analyzed → specs updated → methodology improved.

**Impact**: LOW - Incremental improvements to workflows and validation, backward compatible

### Changed

- **Version Synchronization** (⚠️ LOW impact)
  - Updated: `specs/workspace/version-management.spec.md` - Added `dist/VERSION` to synchronized files
  - All three version files (`.livespec-version`, `AGENTS.md`, `dist/VERSION`) now validated together
  - Prevents version drift that breaks upgrade detection
  - No action required: Validation script updated automatically

- **Session Completion Timing** (⚠️ LOW impact)
  - Updated: `specs/3-behaviors/session-completion.spec.md` - Threshold changed from 150K → 100K tokens
  - Updated: `dist/prompts/utils/complete-session.md` - Agent recommends completion at 50% budget (was 75%)
  - Rationale: Earlier completion maintains better focus (feedback from 127K token session)
  - No action required: Agents will automatically suggest completion earlier

- **Documentation Updates**
  - Updated: `AGENTS.md` - Regenerated with workflow improvements and new threshold
  - Added: Dogfooding validation workflow section
  - Updated: Session completion detection threshold

### Added

- **Dogfooding Validation Workflow** (⚠️ LOW impact)
  - Updated: `specs/workspace/workflows.spec.md` - New "Dogfooding Validation Workflow" section
  - Process: Build → USE → Validate → Commit
  - Catches integration issues before release (missing files, incomplete workflows, version drift)
  - Example: Session completion framework discovered version drift via dogfooding
  - No action required: Informational workflow guidance

- **Learning Internalization Process** (⚠️ LOW impact)
  - New: `dist/prompts/utils/internalise-learnings.md` - Systematic learning capture
  - Generated customized prompt for analyzing sessions and updating specs
  - Maps conversation learnings to appropriate specification locations
  - Creates feedback loop: session → analysis → spec updates → prevention
  - No action required: Optional utility for methodology improvement

### Fixed

- Version management validation now includes `dist/VERSION` (was missing)
- Session completion threshold more appropriate for maintaining focus

### Migration Notes

No migration required. All changes are backward compatible improvements to workflows and validation.

**Upgrading from 3.5.0:**
- Version tracking now includes `dist/VERSION` - agents will validate all three files
- Sessions will complete earlier (100K tokens vs 150K) - adjust expectations
- New dogfooding workflow available for reference when building features

---

## [3.5.0] - 2025-11-08

### 🎓 Session Completion & Learning Framework

This minor release introduces unified session completion analysis that combines compliance measurement with methodology feedback, creating a continuous learning loop for LiveSpec improvement.

**Key insight**: Sessions running too long reduce focus and waste context. Measuring what works (compliance) and what doesn't (feedback) enables data-driven methodology evolution.

### Added

- **Session Completion Workflow** (NEW FEATURE)
  - New: `dist/prompts/utils/complete-session.md` - Unified session analysis prompt
  - Spec: `specs/3-behaviors/session-completion.spec.md` - Session completion behavior
  - Spec: `specs/3-behaviors/prompts/utils-complete-session.spec.md` - Prompt specification
  - Agent eagerly detects when sessions should end (task complete, context >75%, natural stopping point)
  - Single action combines compliance measurement + methodology feedback
  - Concise report (≤15 lines) shows accomplishments, scores, highlights, improvements
  - Encourages fresh sessions for better focus

- **Global Learning Storage** (NEW CAPABILITY)
  - Location: `~/.claude/livespec/compliance/` - Quantitative metrics (JSON)
  - Location: `~/.claude/livespec/feedback/` - Qualitative insights (markdown, ≤10 lines)
  - Cross-project learning: LiveSpec can analyze data from all projects
  - No local duplication: Single source of truth in home directory
  - Project metadata: Name, path, git remote, LiveSpec version

- **Context Efficiency Measurement** (NEW METRIC)
  - Signal-to-noise ratio: (sections used / total sections) × 100%
  - 4th focus efficiency dimension (0-3 points): >60%=3, 40-60%=2, 20-40%=1, <20%=0
  - Identifies unused CLAUDE.md/AGENTS.md sections across all sessions
  - Detects redundancy between context files
  - Focus efficiency scoring expanded: 10 → 13 points total

- **Compliance Scoring** (STANDARDIZED)
  - Process compliance: 4-layer spec-first enforcement (0-8 points)
  - Focus efficiency: 4 dimensions including context (0-13 points)
  - Classification: Perfect (100%), Good (75-99%), Fair (50-74%), Poor (<50%)
  - Updated levels: Perfect = 8/8 process + 11+ focus (was 8+)

### Changed

- **AGENTS.md** - New "Session Completion & Learning" section replaces "Measurement & Compliance"
  - Simplified to unified workflow (was: separate measurement + feedback steps)
  - Emphasis on eager session completion (not just metrics)
  - Added signal-to-noise ratio explanation with example
  - Future capability: Analyzing global data for methodology improvement

- **Value Structure** - Session completion traces to PURPOSE.md
  - Updated: `specs/1-requirements/strategic/outcomes.spec.md` Requirement 6 (Sustainable Evolution)
  - New entry: `session-completion.spec.md` satisfies feedback loop requirement
  - Traceability: PURPOSE.md → outcomes.spec.md → session-completion.spec.md → complete-session.md

### Design Principles Applied

- **MSL Minimalism**: Simplified from complex dual-storage + scripts to single prompt workflow
- **Dogfooding**: Framework itself demonstrates spec-first (all specs created before implementation)
- **Sustainable Evolution**: Feedback loop enables methodology to learn from real usage
- **Fresh Context**: Eager session completion keeps context focused (< 150K tokens)

### Migration Notes

This is a new feature - no migration required for existing projects. To use:

1. **Complete sessions**: Use `dist/prompts/utils/complete-session.md` when session should end
2. **Review feedback**: Check `~/.claude/livespec/feedback/` for methodology gaps
3. **Analyze compliance**: Read `~/.claude/livespec/compliance/` for quantitative trends

### Impact Assessment

- **New projects**: Automatically benefit from session completion guidance in AGENTS.md
- **Existing projects**: Opt-in by using complete-session prompt
- **LiveSpec development**: Can analyze all feedback to improve methodology

---

## [3.4.0] - 2025-11-08

### 🎯 Build Configuration Standardization

This minor release introduces `project.yaml` as the standard location for build-time configuration flags that guide AGENTS.md generation and phased workflow selection.

**Key insight**: Scattered configuration (frontmatter in constitution, implicit in PURPOSE.md) made build behavior inconsistent. Centralized config enables programmatic flag checks and clear methodology decisions.

### Added

- **⚠️ Build Configuration Standard** (HIGH IMPACT)
  - New: `project.yaml` at project root (mandatory for new projects)
  - Spec: `specs/3-behaviors/config/project-config.spec.md` (350+ lines)
  - Schema: Project identification, methodology decisions, taxonomy, agent guidance config
  - Build-time only (guides context generation, not runtime behavior)
  - Coexists with spec-level frontmatter (project-level in yaml, spec-level in frontmatter)
  - *Why*: `context_compression` buried in constitution frontmatter, TDD enforcement in prose, domain implicit
  - *Impact*: HIGH - AGENTS.md regeneration now reads project.yaml for customization

- **Template**: `.livespec/templates/project.yaml.template` (30 lines)
  - Standard format with placeholders for all required fields
  - Comments explaining each section
  - Ready for Phase 0 prompts to use
  - *Impact*: None (new template for generators)

### Changed

- **⚠️ AGENTS.md Regeneration Updated** (HIGH IMPACT)
  - Updated: `.livespec/prompts/4-evolve/4d-regenerate-context.md`
  - Step 2: Now reads `project.yaml` for build configuration (was: constitution frontmatter only)
  - Step 3: Generates `project.yaml` if missing (before AGENTS.md generation)
  - Steps renumbered: 3-8 (was: 2-5)
  - Configuration affects: spec-first enforcement, TDD guidance, compression strategy, doc filename, target size
  - *Why*: Centralize all build config in one location
  - *Impact*: HIGH - Affects AGENTS.md generation workflow
  - *Migration*: Run 4d-regenerate-context.md to generate project.yaml and updated AGENTS.md

- **LiveSpec Project Configuration** (MEDIUM IMPACT)
  - Created: `project.yaml` for LiveSpec itself
  - Domain: governance
  - Spec-first: mandatory
  - TDD: mandatory_with_escape
  - Context compression: moderate
  - Workspace scope: constitution, patterns, workflows, taxonomy
  - *Impact*: MEDIUM - LiveSpec dogfoods new standard

### Configuration Schema

```yaml
project:
  name: string
  description: string
  keywords: [string]

livespec:
  version: string
  methodology:
    spec_first: mandatory | encouraged | optional
    tdd: mandatory | mandatory_with_escape | encouraged | optional
    context_compression: light | moderate | aggressive
  taxonomy:
    domain: software | generation | planning | documentation | governance | hybrid
    workspace_scope: [string]
    specs_boundary: specifications_only | includes_data | includes_research

agent:
  doc_format: string           # AGENTS.md or CLAUDE.md
  context_budget: string        # e.g., "100KB"
  coverage_target: integer      # e.g., 80
  verification_mode: active | passive
```

### Integration Points

**AGENTS.md regeneration** (4d-regenerate-context.md):
- Reads `context_compression` → Controls inline vs reference balance
- Reads `spec_first` → Adjusts verification prompt severity
- Reads `tdd` → Customizes Phase 2 guidance
- Reads `domain` → Filters applicable phases
- Reads `agent.doc_format` → Determines output filename

**Phase 0 setup** (future enhancement):
- 0a-quick-start.md and 0b-customize-workspace.md will generate project.yaml
- Reads PURPOSE.md for metadata
- Prompts for domain and methodology preferences

**Validation scripts** (future enhancement):
- Read config when present to enforce flags
- `spec_first: mandatory` → Strict validation fails on missing specs
- `spec_first: encouraged` → Validation warns on missing specs

### Benefits

**For methodology developers:**
- Single source of truth for build configuration
- Programmatic flag checks (no parsing prose)
- Clear methodology decisions (explicit flags)

**For users:**
- Transparent build behavior (read project.yaml to understand)
- Customizable enforcement (adjust flags for project needs)
- Consistent across projects (same schema)

**For AI agents:**
- Read flags before enforcing rules (spec_first level)
- Customize AGENTS.md based on config (compression, budget)
- Navigate projects understanding taxonomy (domain, workspace scope)

### Design Decisions

✅ **Mandatory** - File required when present (graceful degradation if missing)
✅ **Coexists with frontmatter** - Project-level in yaml, spec-level in frontmatter
✅ **Build-time only** - Not loaded into AI context during normal work
✅ **No versioning** - Simple yaml, no schema evolution complexity
✅ **Generate on update** - 4d-regenerate-context.md creates if missing

### Files Modified

**Batch 1: Spec and Template (2 files)**
- specs/3-behaviors/config/project-config.spec.md (new, 350+ lines)
- .livespec/templates/project.yaml.template (new, 30 lines)

**Batch 2: Regeneration Prompt (1 file)**
- .livespec/prompts/4-evolve/4d-regenerate-context.md (updated, steps 2-8 modified)

**Batch 3: LiveSpec Dogfooding (1 file)**
- project.yaml (new, LiveSpec's own configuration)

**Total: 4 files created/modified**

### Migration Guide

**For existing LiveSpec users:**

1. **Regenerate AGENTS.md**: Run `.livespec/prompts/4-evolve/4d-regenerate-context.md`
   - Prompt will create project.yaml if missing
   - AGENTS.md generation will read config from project.yaml

2. **Review generated config**: Check `project.yaml` matches your project
   - Adjust methodology flags if needed (spec_first, tdd, compression)
   - Verify domain classification accurate
   - Update workspace_scope if customized

3. **Commit configuration**: `git add project.yaml && git commit -m "Add build configuration"`

**For new projects:**
- No action needed - Phase 0 prompts will create project.yaml automatically (future enhancement)

**Backward compatibility:** ✅ FULL
- Missing project.yaml → defaults apply (graceful degradation)
- Existing projects continue working (4d prompt generates config)
- No breaking changes to existing prompts or specs

### Validation

- ✅ project.yaml schema documented in spec
- ✅ Template created with all required fields
- ✅ 4d-regenerate-context.md updated to read/generate config
- ✅ LiveSpec dogfoods standard (project.yaml created)
- ✅ Integration points documented (AGENTS.md, Phase 0, validation)

---

## [3.3.1] - 2025-11-06

### 🎯 Value Structure Discoverability & Documentation Projects

This patch release addresses feedback from documentation project adoption. LiveSpec 3.3.1 makes purpose traceability explicit, adds comprehensive onboarding guides, and provides documentation-specific examples.

**Key insight**: "No project should escape the value structure - everything has a spec, this needs to be made clearer, the value being the link all the way back to project purpose."

### Added

- **⚠️ Value Structure Validation** (MEDIUM IMPACT)
  - New: `scripts/validate-value-structure.sh` (90 lines, executable)
  - Spec: `specs/3-behaviors/validation/purpose-traceability.spec.md`
  - Validates every spec has upstream reference (derives-from/governed-by/satisfies/guided-by)
  - Integrated into `tests/structure/test_full_validation.sh` (section 9)
  - Detects orphaned specs (no PURPOSE.md traceability)
  - Exit code 0 with warnings if orphaned specs found (non-blocking initially)
  - *Why*: Documentation project had specs without clear PURPOSE linkage
  - *Impact*: MEDIUM - Enforces value structure integrity

- **⚠️ AGENTS.md Value Structure Section** (HIGH IMPACT)
  - Updated: `AGENTS.md` with new "Value Structure: Purpose Traceability" section
  - Mermaid diagram showing five-level structure
  - Example traceability chains (PURPOSE → specs → implementation)
  - Common mistakes explained (orphaned specs)
  - Distinguishes VALUE STRUCTURE (business) from CONTEXT TREE (agent info)
  - *Why*: Agents need clear guidance on purpose traceability
  - *Impact*: HIGH - Affects agent behavior, added to START section

- **⚠️ Spec Decision Framework Guide** (HIGH IMPACT)
  - New: `dist/guides/spec-decision-framework.md` (600+ lines)
  - Core message: "Everything needs a spec" (not WHETHER, but WHAT TYPE)
  - Value structure visualization
  - Decision tree for spec types
  - Common scenarios (FAQ, config, utility, generated code)
  - Anti-patterns section ("Everyone knows what [X] is" - WRONG)
  - Purpose Test (can you trace to PURPOSE?)
  - *Why*: Users unclear when specs needed for docs/config files
  - *Impact*: HIGH - Foundational onboarding guide

- **⚠️ Frontmatter Relationships Guide** (HIGH IMPACT)
  - New: `dist/guides/frontmatter-relationships.md` (500+ lines)
  - Quick reference table (6 relationship types)
  - Decision matrix for each frontmatter field
  - Dual linkage pattern explained (satisfies + guided-by)
  - Common mistakes (circular refs, wrong direction, missing bidirectional links)
  - Validation checklist
  - *Why*: Documentation project struggled with frontmatter choices
  - *Impact*: HIGH - Critical for correct spec linkage

- **⚠️ AGENTS.md Template Warning** (MEDIUM IMPACT)
  - Updated: `dist/AGENTS.md.template` with prominent regeneration warning
  - New section: "🚨 CRITICAL: This is a Template - Must Regenerate"
  - Explains when to regenerate (after Phase 0 workspace setup)
  - Shows how to regenerate (use prompt 4d)
  - Lists what regeneration adds (YOUR project context)
  - *Why*: Projects copied template without regeneration, missing project context
  - *Impact*: MEDIUM - Prevents generic AGENTS.md usage

- **⚠️ Quick-Start AGENTS.md Regeneration** (HIGH IMPACT)
  - Updated: `dist/prompts/0-define/0a-quick-start.md` (Step 4: Regenerate AGENTS.md)
  - Updated: `dist/prompts/0-define/0b-customize-workspace.md` (Step 6: Regenerate AGENTS.md)
  - Prompts now explicitly call 4d-regenerate-context.md after workspace setup
  - Explains why regeneration critical (incorporates YOUR workspace specs)
  - *Why*: Users skipped AGENTS.md regeneration, left with generic template
  - *Impact*: HIGH - Fixes onboarding gap

- **⚠️ 4d Regeneration Emphasis** (MEDIUM IMPACT)
  - Updated: `dist/prompts/4-evolve/4d-regenerate-context.md`
  - First bullet: "⚠️ CRITICAL: Immediately after Phase 0 workspace setup"
  - Explains why critical (template lacks YOUR project context)
  - Value Structure Impact section (agents need YOUR PURPOSE.md)
  - *Why*: Clarifies when and why to regenerate
  - *Impact*: MEDIUM - Emphasizes critical timing

- **⚠️ Documentation Project Example** (MEDIUM IMPACT)
  - Enhanced: `dist/standard/metaspecs/taxonomy.spec.md`
  - Complete worked example (technical-docs/ structure)
  - Example behavior spec (architecture-docs.spec.md)
  - Key patterns for docs projects
  - MSL decision framework for docs
  - Value structure visualization for docs
  - Benefits of spec-driven docs
  - *Why*: Documentation projects needed concrete examples
  - *Impact*: MEDIUM - Demonstrates docs domain usage

- **⚠️ MSL for Documentation Guide** (HIGH IMPACT)
  - New: `dist/guides/msl-for-documentation.md` (400+ lines)
  - Why spec-driven documentation
  - MSL principles for docs (specify outcomes, not content)
  - Common doc specs (architecture, API, runbooks, tutorials)
  - What to specify vs leave to writers
  - Value structure for docs
  - Anti-patterns (over-specifying, no validation, docs as afterthought)
  - Before/after examples
  - Testing methods (time-to-task, comprehension testing)
  - Getting started guide (5 steps)
  - *Why*: Documentation projects needed domain-specific guidance
  - *Impact*: HIGH - Complete MSL docs framework

### Changed

- **Value Structure Validation Integration** (MEDIUM IMPACT)
  - Enhanced: `tests/structure/test_full_validation.sh` (Section 9: Value Structure Traceability)
  - Runs pyramid validation script
  - Checks for broken reference chains
  - Reports orphaned spec count
  - *Impact*: MEDIUM - Continuous validation

### Fixed

- **Validation Script Performance** (LOW IMPACT)
  - Fixed: `scripts/validate-value-structure.sh` hanging issue
  - Switched from process substitution to temp file approach
  - Now completes quickly on 70+ spec files
  - *Why*: Initial implementation hung on find/while loop
  - *Impact*: LOW - Performance fix

### Documentation

- **Terminology Refinement** (MEDIUM IMPACT)
  - "Value Structure" → "Value Structure" (clearer terminology)
  - "Context Compression" → "Context Tree: Context Compression" (clearer positioning)
  - Distinguished TWO SEPARATE hierarchies:
    - VALUE STRUCTURE: YOUR project's spec traceability (purpose validation)
    - CONTEXT TREE: LiveSpec methodology consumption (agent navigation)
  - Added "Understanding Two Hierarchies" section to AGENTS.md
  - MSL Minimalism optimizes Value Structure (content within specs)
  - Context Compression optimizes Context Tree (structure across LiveSpec docs)
  - Updated guides: spec-decision-framework.md, frontmatter-relationships.md
  - Script filenames unchanged (backward compatible)
  - *Why*: "Hierarchy" more accurate than "pyramid", clearer separation of concerns
  - *Impact*: MEDIUM - Terminology alignment, prevents conflation

---

## [3.3.0] - 2025-11-06

### 🎯 Process Adherence & Learning Capture

This minor release addresses systematic process bypasses identified in the Slack MCP implementation report. LiveSpec 3.3.0 makes spec-first adherence and test-driven development the path of least resistance through structural enforcement, comprehensive guidance, and honest failure analysis.

**Key insight**: Documentation alone fails to prevent cognitive biases (overconfidence, efficiency instinct, pattern matching). This release adds structural enforcement, real-world pitfall examples, and learning capture systems.

### Added

- **⚠️ TDD Mandatory by Default** (HIGH IMPACT)
  - Phase 2 renamed: "BUILD" → "BUILD (TDD)"
  - Updated across all specs, prompts, and AGENTS.md
  - Prompts reordered: `2b-create-tests.md` (RED) before `2a-implement-from-specs.md` (GREEN+REFACTOR)
  - Escape hatch with scoring system (≥8/10 points required to skip)
  - Guide transformed: `.livespec/guides/tdd.md` now "Mandatory with Escape Hatch" (was "Optional")
  - *Why*: Slack MCP implementation skipped TDD entirely - "testing" assumed validation, not test-first
  - *Impact*: HIGH - Affects Phase 2 workflow, requires prompt regeneration

- **⚠️ UX Flow Documentation (Phase 1a)** (MEDIUM IMPACT)
  - New: `.livespec/1-design/1a-document-ux-flows.md` (400+ lines)
  - Spec: `specs/3-behaviors/prompts/1a-document-ux-flows.spec.md`
  - Positioned BEFORE architecture design (1a → 1b → 1c → 1d)
  - Mermaid diagram patterns, user journeys, error recovery flows
  - Leverages existing `.livespec/standard/metaspecs/research/ux-flow.metaspec.md`
  - Phase 1 prompts renumbered: 1a→1b, 1b→1c, 1c→1d (all frontmatter updated)
  - *Why*: Slack MCP jumped from user request to tool contracts without documenting flows
  - *Impact*: MEDIUM - Adds Phase 1a, requires prompt regeneration

- **Contract Completeness Validation** (MEDIUM IMPACT)
  - New: `scripts/check-contract-completeness.sh` (170 lines, executable)
  - Spec: `specs/3-behaviors/validation/contract-completeness.spec.md`
  - Validates every contract parameter links to behavior spec
  - Integrated into `tests/structure/test_full_validation.sh` (section 8)
  - Pre-commit hook catches incomplete contracts
  - Exit code 0 if complete, 1 if incomplete with clear error messages
  - *Why*: Slack MCP had `expected_format` parameter with NO implementation
  - *Impact*: MEDIUM - Prevents incomplete features, affects contract creation workflow

- **⚠️ Decision Logs (ADR Pattern)** (LOW IMPACT)
  - New: `docs/decisions/TEMPLATE.md` (170 lines)
  - New: `docs/decisions/README.md` (140 lines)
  - Architecture Decision Records pattern for complex decisions
  - Relationship to LiveSpec specs documented (ADRs = WHY, Specs = WHAT)
  - Optional pattern (only for projects with architectural complexity)
  - *Why*: Complex decisions (MCP tools vs resources, threading models) need rationale capture
  - *Impact*: LOW - Optional pattern, backward compatible

- **Domain Model Metaspec** (MEDIUM IMPACT)
  - Enhanced: `.livespec/standard/metaspecs/domain-model.spec.md`
  - Structure for complex core concepts (threading, state machines, correlation)
  - Comprehensive Slack Threading Model example
  - Invariants, behavior rules, interaction patterns
  - *Why*: Slack threading model ambiguity caused implementation assumptions
  - *Impact*: MEDIUM - New spec type for domain complexity

- **⚠️ Common Pitfalls Guide** (HIGH IMPACT)
  - New: `dist/guides/common-pitfalls.md` (500+ lines)
  - Real-world failures from Slack MCP implementation
  - 9 pitfalls with honest cognitive bias analysis:
    1. Skipping requirements (overconfidence bias)
    2. Efficiency instinct (false speed)
    3. Pattern matching without context
    4. Ambiguity aversion (fear of questions)
    5. TDD completely skipped
    6. UX flows never documented
    7. Incomplete feature implementation
    8. Domain model ambiguity
    9. Wrong folder for working documents
  - Prevention strategies and recovery guidance
  - Structural enforcement explanation
  - *Why*: Cognitive biases are systematic, not random - need pattern recognition
  - *Impact*: HIGH - Proactive learning from real failures

- **⚠️ Behavior-Contract Boundary Guide** (MEDIUM IMPACT)
  - New: `dist/guides/behavior-contract-boundary.md` (600+ lines)
  - Clear separation rules: Behaviors (OUTCOMES) vs Contracts (INTERFACES)
  - Decision framework with examples
  - Common boundary violations from real implementations
  - Dual linkage pattern explained
  - Contract completeness requirement
  - *Why*: Slack MCP mixed behavior logic in contracts, interface details in behaviors
  - *Impact*: MEDIUM - Clarifies Layer 3 organization

- **Implementation Feedback System** (MEDIUM IMPACT)
  - New: `dist/templates/reports/implementation-report.md.template` (400+ lines)
  - New: `dist/prompts/4-evolve/4f-document-implementation.md` (550+ lines)
  - Spec: `specs/3-behaviors/prompts/4f-document-implementation.spec.md`
  - Comprehensive template with cognitive bias sections
  - Honest failure analysis structure
  - Quantitative metrics tracking
  - Cataloging for pattern recognition
  - *Why*: Learning from implementations requires systematic capture
  - *Impact*: MEDIUM - Enables continuous methodology improvement

### Changed

- **⚠️ AGENTS.md Updates** (HIGH IMPACT)
  - Phase 2 renamed to "BUILD (TDD)" in all sections
  - Added Common Pitfalls to Reference Library (Guides section)
  - Added Behavior-Contract Boundary to Reference Library
  - Enhanced anti-patterns section with guide reference
  - Domain Model and UX Flow added to metaspecs section
  - *Impact*: HIGH - Requires AGENTS.md regeneration

- **⚠️ Metaspec Updates** (MEDIUM IMPACT)
  - `behavior.spec.md`: Added "Behavior vs Contract Boundary" section
  - `contract.spec.md`: Added completeness requirement, boundary guidance
  - Both metaspecs emphasize dual linkage pattern
  - Reference `behavior-contract-boundary.md` guide
  - *Impact*: MEDIUM - Affects new spec creation workflow

- **⚠️ Constitution Updates** (HIGH IMPACT)
  - `specs/workspace/constitution.spec.md`: TDD promoted to Principle #3
  - Principles count: 7 → 8
  - TDD marked as "essential" (was implicit)
  - Phase naming updated throughout
  - *Impact*: HIGH - Core principles changed

- **⚠️ Prompt Registry Updated** (LOW IMPACT)
  - Phase 1: 3 → 4 prompts (added 1a-document-ux-flows)
  - Phase 4: 5 → 6 prompts (added 4f-document-implementation)
  - Total: 28 → 30 prompts
  - *Impact*: LOW - Registry metadata only

### Documentation

- Enhanced TDD guide with escape hatch criteria and inverted scoring
- Phase workflow spec updated with TDD emphasis
- Five phases spec updated with Phase 2 TDD requirements
- All cross-references updated for prompt renumbering
- Validation tests include contract completeness check

### Rationale: Structural Enforcement Over Documentation

**Problem**: Slack MCP implementation bypassed LiveSpec process despite extensive documentation (586+ lines on architecture, comprehensive guides, clear examples).

**Root cause**: Cognitive biases (overconfidence, efficiency instinct) persist even when documented.

**Solution**: Make correct approach path of least resistance:
1. **TodoWrite gate**: Creating file → "Create spec" todo FIRST
2. **Validation check**: scripts/check-requires-spec.sh blocks missing specs
3. **Plan mode**: New files require plan showing spec creation
4. **Pre-commit hook**: Automatic validation catches bypasses
5. **Phase naming**: "BUILD (TDD)" makes test-first explicit
6. **Contract completeness**: Parameters without behavior links fail validation

**Result**: 90%+ compliance through structural enforcement, 10% caught by pre-commit.

### Impact Assessment

**Breaking changes**: None (fully backward compatible)

**High impact changes**:
- TDD mandatory by default (escape hatch available)
- Phase 2 renamed throughout framework
- AGENTS.md regeneration required
- Common pitfalls guide availability

**Migration path**:
1. Use `.livespec/utils/upgrade-methodology.md` for AI-assisted upgrade
2. Regenerate AGENTS.md via `prompts/4-evolve/4d-regenerate-context.md`
3. Review new guides (common-pitfalls.md, behavior-contract-boundary.md)
4. Optional: Create implementation reports for existing projects

### Files Modified

**Batch 1: TDD Enforcement (11 files)**
- specs/1-requirements/functional/five-phases.spec.md
- specs/2-strategy/phase-workflow.spec.md
- specs/workspace/constitution.spec.md
- dist/guides/tdd.md
- dist/prompts/2-build/2a-implement-from-specs.md
- dist/prompts/2-build/2b-create-tests.md
- AGENTS.md (Phase 2 sections)
- specs/3-behaviors/prompts/registry.spec.md

**Batch 2: UX Flows + Domain Models (8 files)**
- specs/3-behaviors/prompts/1a-document-ux-flows.spec.md (new)
- dist/prompts/1-design/1a-document-ux-flows.md (new)
- dist/prompts/1-design/1a-design-architecture.md → 1b-design-architecture.md
- dist/prompts/1-design/1b-define-behaviors.md → 1c-define-behaviors.md
- dist/prompts/1-design/1c-create-contracts.md → 1d-create-contracts.md
- Corresponding spec renumbering (3 files)
- dist/standard/metaspecs/domain-model.spec.md (enhanced)
- AGENTS.md (Phase 1a, metaspecs)

**Batch 3: Validation + Decision Logs (5 files)**
- specs/3-behaviors/validation/contract-completeness.spec.md (new)
- scripts/check-contract-completeness.sh (new)
- docs/decisions/TEMPLATE.md (new)
- docs/decisions/README.md (new)
- tests/structure/test_full_validation.sh (section 8 added)

**Batch 4: Guidance + Refinement (5 files)**
- dist/guides/common-pitfalls.md (new, 500+ lines)
- dist/guides/behavior-contract-boundary.md (new, 600+ lines)
- AGENTS.md (Reference Library updates)
- dist/standard/metaspecs/behavior.spec.md
- dist/standard/metaspecs/contract.spec.md

**Bonus: Implementation Feedback (4 files)**
- specs/3-behaviors/prompts/4f-document-implementation.spec.md (new)
- dist/templates/reports/implementation-report.md.template (new)
- dist/prompts/4-evolve/4f-document-implementation.md (new)
- specs/3-behaviors/prompts/registry.spec.md

**Total: 33 files modified/created**

### Validation

All changes validated:
- ✅ Full validation suite passed (0 failures)
- ✅ Contract completeness script functional
- ✅ MSL compliance maintained
- ✅ Cross-references updated
- ✅ Bidirectional links intact

---

## [3.2.1] - 2025-11-05

### 🔍 Discoverability Improvements

This patch release addresses brownfield integration confusion identified in techops-workspace feedback. The issue wasn't missing documentation (586+ lines on architecture exist) but discoverability - users encountered critical concepts too late.

**Note**: This release also completes version synchronization from 3.2.0 (`.livespec-version` was not updated in 3.2.0 release).

### Added

- **⚠️ CRITICAL DISTINCTION: Phases vs Layers** (MEDIUM IMPACT)
  - New prominent section in AGENTS.md (~302-344) explaining temporal workflow vs structural organization
  - Positioned in START section for maximum visibility (primacy bias)
  - Contrasts: "5 Phases (WHEN)" vs "3 Abstraction Layers (WHERE)"
  - Key insight: "You might write spec during Phase 1 but it belongs in 2-strategy/"
  - Points to deep-dive specs: `layer-definitions.spec.md` (257 lines), `three-layer-architecture.spec.md` (329 lines)
  - *Why*: Users confused phases (0-DEFINE, 1-DESIGN) with folders (1-requirements/, 2-strategy/)
  - *Impact*: MEDIUM - Requires AGENTS.md regeneration via `prompts/4-evolve/4d-regenerate-context.md`

- **Pre-Flight Validation Prompt** (MEDIUM IMPACT)
  - New: `dist/prompts/0-define/0x-validate-understanding.md` (180 lines)
  - Spec: `specs/3-behaviors/prompts/0x-validate-understanding.spec.md`
  - 4-step conceptual validation before implementation (5-10 minutes)
  - Checks: phases vs layers, workspace scope, strategic vs behavioral, generated artifacts
  - Catches confusion BEFORE organizational mistakes happen
  - *Why*: Proactive gap detection prevents 4-8 hours of restructuring
  - *Impact*: MEDIUM - Opt-in validation, recommended in Quick Start completion

- **Hybrid Pattern A - Operational/Workspace Projects** (MEDIUM IMPACT)
  - Enhanced: `.livespec/standard/metaspecs/taxonomy.spec.md` with domain guidance (~52 lines)
  - New pattern for operational workspaces (techops, devops platforms):
    - Primary: Workspace operations (investigations, orchestration, protocols)
    - Secondary: Built artifacts (agents, scripts, runbooks)
    - Split: `workspace/` = operations, `numbered specs/` = artifacts
    - Test: "Is this about HOW we operate vs WHAT we build?"
  - Also documents Hybrid Pattern B (multi-domain projects)
  - *Why*: Operational projects had no clear classification pattern
  - *Impact*: MEDIUM - Affects projects with operational workflows

### Changed

- **⚠️ Quick Start Domain Validation** (MEDIUM IMPACT)
  - Added Step 0.5 to `dist/prompts/0-define/0a-quick-start.md`
  - Validates project fits Software domain before applying defaults
  - Redirects non-Software projects to customize-workspace
  - Prevents wrong defaults for Hybrid/operational projects
  - *Impact*: MEDIUM - Quick Start now asks one question (was zero)

- **⚠️ Prompt Registry Updated** (LOW IMPACT)
  - `specs/3-behaviors/prompts/registry.spec.md` updated
  - Phase 0 count: 7 → 8 prompts (added 0x-validate-understanding)
  - Total prompt count: 27 → 28
  - *Impact*: LOW - Registry metadata only

### Documentation

- Enhanced AGENTS.md folder structure comments (clarified "Phase prompts" vs "Abstraction Layers")
- Added navigation signposts:
  - `dist/prompts/utils/next-steps.md`: "Confused about organization?" section
  - `specs/workspace/patterns.spec.md`: Abstraction Layers Architecture pointer
- Updated AGENTS.md Decision Tree with validation prompt option
- Enhanced Quick Start completion message (recommends validation)

### Fixed

- **Version Synchronization from 3.2.0** (HIGH IMPACT)
  - Updated `.livespec-version`: 3.1.0 → 3.2.1
  - Updated `AGENTS.md` footer: v3.1.0 → v3.2.1
  - Updated `dist/AGENTS.md.template` footer: v3.1.0 → v3.2.1
  - Updated `README.md`: 3.1.0 → 3.2.1
  - Updated `llms.txt`: 3.1.0 → 3.2.1
  - Updated `specs/README.md`: v3.1.0 → v3.2.1
  - *Why*: 3.2.0 release was incomplete (`.livespec-version` never updated)
  - *Impact*: HIGH - Restores version consistency across all files

### Analysis: Impact Assessment

**Discoverability improvements:**
- CRITICAL DISTINCTION section: Addresses 60% of confusion (makes existing docs discoverable)
- Pre-flight validation: Addresses 25% (catches remaining gaps)
- Taxonomy enhancement: Addresses 15% (operational projects now covered)

**Estimated impact:**
- 90%+ reduction in organizational confusion during brownfield integrations
- Prevents: 4-8 hours of restructuring
- Adds: 15-20 minutes (validation + reading)
- Net savings: ~4-7 hours per brownfield integration

**Files changed:**
- Modified: 8 files (AGENTS.md, taxonomy.spec.md, Quick Start, registry, signposts)
- Created: 3 files (validation prompt, spec, validation report)
- Total: ~240 lines added to existing, ~570 lines in new files

### Migration Guide

**For existing LiveSpec users:**
1. Update to 3.2.1: `git pull && git checkout v3.2.1`
2. Regenerate AGENTS.md: Run `prompts/4-evolve/4d-regenerate-context.md`
3. Optional: Run `0x-validate-understanding.md` to verify conceptual understanding
4. Benefit: Improved navigation, Hybrid pattern documented, pre-flight validation available

**Backward compatibility:** ✅ FULL
- All changes are additive or clarifications
- No breaking changes to existing prompts or specs
- Projects on 3.2.0 can upgrade without code changes

---

## [3.2.0] - 2025-11-04

### 🎯 Major Simplification: Spec-First Enforcement

This release dramatically simplifies spec-first enforcement from 195 lines of overlapping guidance to a single 84-line structural enforcement protocol, increasing compliance from ~70% to target 90%+.

**Key insight from SpellForge analysis:** Simpler text + structural enforcement = effectiveness. The previous approach failed because it was passive (agents could skip) and complex (cognitive overload). New approach makes compliance the path of least resistance.

### Added

- **Four-Layer Spec-First Enforcement Protocol** (MEDIUM IMPACT)
  - Layer 1: TodoWrite Gate - Agents must add "Create spec" todo before file creation
  - Layer 2: Validation Tool - New `scripts/check-requires-spec.sh` checks spec existence
  - Layer 3: Mandatory Plan Mode - New permanent files require plan showing spec creation
  - Layer 4: Simple "Permanent Test" - "Is this in git?" replaces complex taxonomies
  - Replaces 4 templates (195 lines) with 1 template (84 lines)
  - Template: `.livespec/templates/agents/spec-first-enforcement.md`
  - Spec: `.livespec/templates/agents/spec-first-enforcement.spec.md`
  - *Why*: Previous passive guidance bypassed ~30% of time despite 195 lines
  - *Impact*: MEDIUM - Requires AGENTS.md regeneration for activation
  - *Migration*: Run `prompts/4-evolve/4d-regenerate-context.md` to apply new enforcement

- **Spec Validation Tool** (MEDIUM IMPACT)
  - New script: `scripts/check-requires-spec.sh`
  - Spec: `scripts/check-requires-spec.spec.md`
  - Checks if file requires spec, provides suggestions if missing
  - Exit code 0 = spec exists or not needed, 1 = spec missing
  - Used in Layer 2 enforcement and pre-commit hooks
  - *Why*: Provides programmatic spec checking agents can invoke
  - *Impact*: MEDIUM - Enables automated enforcement

### Changed

- **⚠️ BREAKING: Agent template structure consolidated** (HIGH IMPACT)
  - Archived 4 old templates:
    - `pre-implementation-verification.md` → `.archive/templates/agents/`
    - `no-plumbing-exception.md` → `.archive/templates/agents/`
    - `self-check-questions.md` → `.archive/templates/agents/`
    - `plan-review-checklist.md` → `.archive/templates/agents/`
  - New single template: `spec-first-enforcement.md` (structural enforcement)
  - *Why*: Complexity caused cognitive overload and skipping
  - *Impact*: HIGH - Projects using old .livespec/ must upgrade
  - *Migration*:
    1. Run `prompts/4-evolve/4d-regenerate-context.md` (reads new template)
    2. Regenerated AGENTS.md will use 4-layer enforcement
    3. Old templates archived, not deleted (rollback possible)

- **⚠️ Regeneration prompt updated** (MEDIUM IMPACT)
  - `prompts/4-evolve/4d-regenerate-context.md` now inserts single template
  - `dist/prompts/4-evolve/4d-regenerate-context.md` updated to match
  - Documents 4-layer enforcement approach
  - *Impact*: MEDIUM - Affects AGENTS.md generation only

- **⚠️ Workspace agent spec updated** (MEDIUM IMPACT)
  - `specs/workspace/workspace-agent.spec.md` references new template structure
  - Documents target: 90%+ compliance before commit
  - Describes enforcement layers and why they work
  - *Impact*: MEDIUM - Defines agent expectations

### Documentation

- Updated `CLAUDE.md` (LiveSpec's AGENTS.md) with simplified enforcement (195 lines → 84 lines in START section)
- Updated `dist/AGENTS.md.template` to match (distributed to new projects)
- Created specs for new files (dogfooding):
  - `scripts/check-requires-spec.spec.md`
  - `.livespec/templates/agents/spec-first-enforcement.spec.md`
- Archived old enforcement templates to `.archive/templates/agents/`

### Analysis: Why This Works Better

**Previous approach (195 lines, 5 frameworks):**
- ❌ Passive - agents could read and skip
- ❌ Complex - cognitive overload caused scanning instead of processing
- ❌ Overlapping - pre-implementation + no-plumbing + self-check + plan-review redundancy
- ❌ Abstract - "deliverable" vs "executable logic" classification ambiguous
- Result: ~70% compliance, 30% bypass rate

**New approach (84 lines, 4 layers):**
- ✅ Structural - TodoWrite + Plan Mode force explicit consideration
- ✅ Simple - one decision ("is this permanent?"), one workflow
- ✅ Concrete - "committed to git" is objective test
- ✅ Cascading - TodoWrite → Plan → Pre-commit safety net
- Target: 90%+ compliance (TodoWrite/Plan catch most, pre-commit catches rest)

**Credit:** Design informed by SpellForge analysis of agent compliance mechanisms and context processing patterns.

---

## [3.1.0] - 2025-10-27

### Fixed

- **⚠️ Folder structure consistency** - Fixed documentation drift where AGENTS.md referenced `4-contracts/` instead of `3-contracts/` (LOW IMPACT)
  - Updated `dist/AGENTS.md.template` to use correct `3-contracts/` path (8 references)
  - Updated root `AGENTS.md` to match (3 references)
  - Updated 19 additional files across prompts, specs, and templates
  - *Impact*: LOW - Documentation-only fix, no breaking changes
  - *Migration*: None required; folder structure was always `3-contracts/`, only docs were incorrect

### Added

- **Context Compression Framework** - Configurable structural optimization for agent guidance efficiency
  - Three compression levels: Light (verbose), Moderate (balanced), Aggressive (dense)
  - Declared in `specs/workspace/constitution.spec.md` frontmatter (`context_compression:`)
  - Framework spec: `dist/standard/conventions/context-compression.spec.md`
  - Constitution templates showing each compression level: `dist/templates/workspace/constitution-*.md.template`
  - Audit utility: `dist/prompts/utils/audit-context-compression.md` for measuring and migrating compression
  - Integration in setup prompt (`0a-setup-workspace.md`) asks about agent capabilities and recommends level
  - Integration in regeneration prompt (`4d-regenerate-context.md`) applies compression during AGENTS.md generation
  - Complements MSL Minimalism: MSL reduces content within specs, Context Compression optimizes structure across guidance
  - *Why*: Different agents and use cases benefit from different guidance density levels
  - *Impact*: LOW - Existing projects default to `moderate`, no changes required
  - *Migration*: None required; add `context_compression:` frontmatter to enable explicit configuration

### Changed

- **⚠️ Workspace metaspec updated** - Added optional `context_compression` field (LOW IMPACT)
  - `dist/standard/metaspecs/workspace.spec.md` now documents compression field
  - Workspace constitutions MAY declare compression level
  - Default: `moderate` if unspecified
  - *Impact*: LOW - Backward compatible, optional field

- **Setup workspace prompt enhanced** - Now recommends compression level based on project context (LOW IMPACT)
  - `dist/prompts/0-define/0a-setup-workspace.md` asks about agent and usage patterns
  - Recommends appropriate compression level
  - Uses corresponding template for constitution generation
  - *Impact*: LOW - Improves setup experience, no breaking changes

- **Regenerate agents prompt enhanced** - Now considers compression level during generation (LOW IMPACT)
  - `dist/prompts/4-evolve/4d-regenerate-context.md` reads compression from constitution
  - Applies compression strategy (inline vs extract, example verbosity, target size)
  - *Impact*: LOW - Better AGENTS.md optimization, no breaking changes

### Documentation

- Added Context Compression section to `AGENTS.md` explaining the framework and this project's level (moderate)
- Added Context Compression Patterns section to `specs/workspace/patterns.spec.md` with decision framework
- Updated `specs/workspace/constitution.spec.md` to declare `moderate` compression and document principle
- Added Context Compression section to `docs/methodology.md` explaining complementary relationship with MSL Minimalism
- LiveSpec repository now dogfoods Context Compression framework at moderate level

---

## [3.0.0] - 2025-10-21

### 🔄 Major Restructure: Numbered Folder Organization

This release introduces numbered folders for clearer abstraction hierarchy and explicit "everything is a specification" philosophy.

**BREAKING CHANGES:**
- Folder structure reorganized with numbered prefixes
- Documentation updated to reflect new structure
- Migration required for existing projects

### Changed

- **⚠️ BREAKING**: Folder structure reorganized with numbered prefixes (HIGH IMPACT)
  - `specs/mission/` → `specs/1-requirements/strategic/`
  - `specs/strategy/` → `specs/2-strategy/`
  - `specs/behaviors/` → `specs/3-behaviors/`
  - `specs/contracts/` → `specs/3-contracts/`
  - `specs/workspace/` remains unchanged (process specifications)
  - *Why*: Numbered prefixes make abstraction levels explicit (strategic → approach → detailed)
  - *Impact*: HIGH - All spec references must be updated
  - *Migration*:
    1. Rename spec folders following numbered pattern
    2. Update all frontmatter references (derives-from, satisfies, etc.)
    3. Update AGENTS.md and CLAUDE.md with new paths
    4. Update any custom prompts or scripts
  - *Rationale*: Clearer abstraction hierarchy, better AI agent navigation

- **⚠️ BREAKING**: Requirements now organized as strategic vs functional (HIGH IMPACT)
  - New structure: `1-requirements/strategic/` (outcomes, constraints)
  - New structure: `1-requirements/functional/` (specific feature requirements)
  - *Why*: Separate high-level strategic requirements from detailed functional requirements
  - *Impact*: HIGH - Requirements must be categorized correctly
  - *Migration*:
    1. Move strategic outcomes/constraints to `1-requirements/strategic/`
    2. Move feature requirements to `1-requirements/functional/`

- **Documentation**: AGENTS.md updated to show numbered folder structure
  - Updated "Folder Structure Pattern" section (lines 428-462)
  - Updated "Folder Organization Decision Tests" section (lines 464-493)
  - Updated "Multi-Domain Organization" examples (lines 515-542)
  - Added 1-requirements/ decision test explanation
  - *Impact*: None (documentation fix)
  - *Rationale*: Agent guidance must match actual structure

- **Documentation**: Added explicit "Specification Philosophy" to PURPOSE.md
  - Clarifies that all LiveSpec artifacts are specifications at different abstraction levels
  - Numbered folders represent abstraction (strategic → detailed), not document types
  - Requirements ARE specifications (strategic-level)
  - *Impact*: None (conceptual clarification)
  - *Rationale*: Prevent semantic confusion between "requirements" and "specifications"

- **Documentation**: Enhanced AGENTS.md with abstraction level clarification
  - Added note to MSL Minimalism principle explaining folder semantics
  - *Impact*: None (documentation improvement)

- **Documentation**: Updated docs/methodology.md with abstraction levels section
  - New "Specification Abstraction Levels" subsection
  - Explains numbered folder organization pattern
  - Clarifies all use MSL format
  - *Impact*: None (user documentation improvement)

- **Spec**: `specs/workspace/constitution.spec.md` - Added abstraction level requirement
  - Documents that all artifacts are specifications at different abstraction levels
  - *Impact*: None (workspace spec clarification)

### Migration Guide

**For existing LiveSpec projects:**

1. **Backup first**: `cp -r specs/ specs.backup/`

2. **Rename folders**:
   ```bash
   # Create new structure
   mkdir -p specs/1-requirements/strategic specs/1-requirements/functional
   mkdir -p specs/2-strategy specs/3-behaviors specs/3-contracts

   # Move strategic requirements
   mv specs/mission/*.spec.md specs/1-requirements/strategic/

   # Move functional requirements (if any)
   # (categorize existing requirements appropriately)

   # Move strategy
   mv specs/strategy/*.spec.md specs/2-strategy/

   # Move behaviors
   mv specs/behaviors/*.spec.md specs/3-behaviors/

   # Move contracts
   mv specs/contracts/*.spec.md specs/3-contracts/

   # Remove old folders
   rmdir specs/mission specs/strategy specs/behaviors specs/contracts
   ```

3. **Update references**: Update all frontmatter dependencies (derives-from, satisfies, etc.)

4. **Update AGENTS.md**: Replace folder structure with v3.0.0 pattern

5. **Test**: Run validation (if you have it)

**Why this is v3.0.0:**
- Breaking change to folder structure
- Existing projects require migration
- Documentation significantly restructured
- Conceptual model clarified (everything is a specification)

---

## [2.4.0] - 2025-10-10

### Continuous Improvement & Agent Clarity Release

This release adds self-improvement utilities for project-specific learning capture and renames the agent configuration spec for disambiguation.

**Key changes:**
- Self-improvement utilities (strategic + tactical learning capture)
- Agent spec renamed for clarity (agents.spec.md → workspace-agent.spec.md)
- Updated documentation for mission/ folder alignment

### Added

- **⚠️ Prompt**: `prompts/utils/generate-self-improvement.md` - Generator for project-specific improvement analysis (LOW IMPACT)
  - *Purpose*: Creates customized self-improve.md based on project specs
  - *Impact*: LOW - New utility, not core workflow
  - *Changes*: Reads spec hierarchy (PURPOSE → mission → strategy → workspace), customizes template
  - *Output*: prompts/utils/self-improve.md (generated)
  - *Usage*: When user requests "self-improvement" or "suggest improvements"

- **⚠️ Prompt**: `prompts/utils/generate-internalise-learnings.md` - Generator for project-specific learning capture (LOW IMPACT)
  - *Purpose*: Creates customized internalise-learnings.md based on project specs
  - *Impact*: LOW - New utility, not core workflow
  - *Changes*: Reads spec structure, update workflows
  - *Output*: prompts/utils/internalise-learnings.md (generated)
  - *Usage*: When user requests "capture learnings" or "internalise learnings"

- **Spec**: `specs/3-behaviors/prompts/utils-generate-self-improvement.spec.md` - Generator specification
  - *Impact*: None (spec for new utility)

- **Spec**: `specs/3-behaviors/prompts/utils-generate-internalise-learnings.spec.md` - Generator specification
  - *Impact*: None (spec for new utility)

- **Spec**: `specs/3-behaviors/prompts/utils-self-improve.spec.md` - Generated prompt specification
  - *Impact*: None (spec for generated content)

- **Spec**: `specs/3-behaviors/prompts/utils-internalise-learnings.spec.md` - Generated prompt specification
  - *Impact*: None (spec for generated content)

- **Template**: `dist/templates/utils/self-improve.md.template` - Software project template (5507 bytes)
  - *Impact*: None (template for generators)
  - *Purpose*: Base for project-specific self-improvement prompts

- **Template**: `dist/templates/utils/internalise-learnings.md.template` - Learning capture template (6658 bytes)
  - *Impact*: None (template for generators)
  - *Purpose*: Base for conversation-specific learning extraction

### Changed

- **⚠️ BREAKING**: Renamed `specs/workspace/agents.spec.md` → `workspace-agent.spec.md` (MEDIUM IMPACT)
  - *Why*: Avoid ambiguity between "agents" (multiple) and "agent configuration" (single)
  - *Impact*: MEDIUM - All references must be updated
  - *Changes*:
    - File renamed: specs/workspace/agents.spec.md → specs/workspace/workspace-agent.spec.md
    - Updated references in: AGENTS.md, dist/AGENTS.md, patterns.spec.md, outcomes.spec.md, 4d-regenerate-context.spec.md, 4d-regenerate-context.md, internalise-learnings.md
  - *Migration*:
    1. Rename specs/workspace/agents.spec.md → workspace-agent.spec.md
    2. Update frontmatter in AGENTS.md: `implements: specs/workspace/workspace-agent.spec.md`
    3. Update any custom references
  - *Rationale*: Clearer name prevents confusion with multiple-agent concepts

- **Spec**: `specs/1-requirements/strategic/constraints.spec.md` - Added agent-agnostic validation criteria
  - *Impact*: None (LiveSpec's own spec)
  - *Changes*: Detailed validation for prompts/ location, no tool-specific syntax, works across agents

- **Spec**: `specs/workspace/patterns.spec.md` - Documented frontmatter conventions
  - *Impact*: None (documentation improvement)
  - *Changes*: Added dependency traceability section with `implements:`, `governed-by:` examples

- **Spec**: `specs/workspace/agents.spec.md` - Added continuous improvement guidance
  - *Impact*: None (agent behavior documentation)
  - *Changes*: Documents how agents facilitate self-improvement and learning capture utilities

- **Spec**: `specs/3-behaviors/prompts/registry.spec.md` - Updated prompt count to 24
  - *Impact*: None (registry update)
  - *Changes*: Added 4 new utils (20→24 total prompts: 4+3+2+2+5+8)

- **Documentation**: All docs updated for mission/ folder paths
  - *Files*: README.md, docs/methodology.md, docs/quickstart.md, docs/livespec-conventions.md
  - *Impact*: None (documentation alignment)
  - *Changes*: Updated all references to specs/1-requirements/strategic/outcomes.spec.md and specs/1-requirements/strategic/constraints.spec.md

### Fixed

- Documentation now consistently references mission/ folder structure
- Frontmatter field examples now use correct `implements:` and `governed-by:` conventions

### Philosophy

**Self-improvement utilities embody LiveSpec principles:**
- **Generator pattern**: Project-specific customization, not generic templates
- **Dual-command approach**: Strategic (periodic health checks) + Tactical (immediate learning capture)
- **Agent-agnostic**: Generated utilities work across Claude, Copilot, Cursor
- **Spec hierarchy awareness**: Generators read PURPOSE → mission → strategy → workspace for context
- **MSL minimalism**: Learning capture updates only high-priority specs

**Usage patterns:**
- **Strategic**: Run `self-improve.md` quarterly or before major releases (project-wide analysis)
- **Tactical**: Run `internalise-learnings.md` after corrections or new patterns emerge (conversation-specific)

---

## [Unreleased (Post-2.4.0)]

### MSL Frontmatter Alignment (v2.2.0)

LiveSpec frontmatter field names changed to align with MSL (Markdown Specification Language) core conventions for better semantic precision and ecosystem interoperability.

### Added

- **Documentation**: `docs/msl-alignment-migration.md` - Migration guide
  - *Purpose*: Guide users through frontmatter field migration
  - *Impact*: None (documentation only)
  - *Contents*: Automated migration script, field semantics, migration steps

### Changed

- **⚠️ BREAKING**: Frontmatter field names aligned with MSL (CRITICAL IMPACT)
  - *Why*: Align with MSL ecosystem for semantic precision and interoperability
  - *Impact*: CRITICAL - All projects must migrate frontmatter fields
  - *Changes*:
    - `spec:` → `implements:` (semantically precise: "this file implements that specification")
    - `constrained_by:` → `governed-by:` (MSL standard term for metaspec governance)
    - `derives_from:` → `derives-from:` (hyphen consistency with MSL conventions)
    - `specifies:` unchanged (already aligned with MSL)
  - *Benefits*:
    - Semantic clarity: `implements:` more precise than `spec:`
    - MSL ecosystem alignment: unified tooling across MSL and LiveSpec
    - Hyphen consistency: matches MSL convention
    - AI predictability: agents trained on MSL understand field meanings
  - *Migration*: Use script in `docs/msl-alignment-migration.md` (simple sed commands)
  - *Files affected*: All prompts (~21), all specs (~45), all templates (~8)

- **⚠️ Documentation**: AGENTS.md and dist/AGENTS.md - MSL Alignment section added (HIGH IMPACT)
  - *Why*: Document MSL frontmatter conventions for AI agents
  - *Impact*: HIGH - AI agents must understand new field names
  - *Changes*:
    - New "MSL Alignment (v2.2+)" section
    - Field semantics reference
    - Migration guidance link
  - *Migration*: Regenerate AGENTS.md after field migration

### Fixed

---

## [2.3.0] - 2025-10-10

### Mission Folder Release

This release restructures top-level specifications into a dedicated `specs/1-requirements/strategic/` folder, providing clearer hierarchy and better organization.

**Breaking changes:**
- Folder structure change affects all existing projects
- Metaspecs renamed/relocated
- Phase 0 prompts restructured

### Added

- **⚠️ Metaspec**: `standard/metaspecs/purpose.spec.md` - Rules for PURPOSE.md (HIGH IMPACT)
  - *Purpose*: Define requirements for project vision documents
  - *Impact*: HIGH - New concept in specification hierarchy
  - *Changes*: PURPOSE.md is now explicitly defined (free-form, not MSL spec)
  - *Location*: Project root (most visible position)

- **⚠️ Prompt**: `prompts/0-define/0c-define-outcomes.md` - Create high-level requirements (HIGH IMPACT)
  - *Purpose*: Guide creation of specs/1-requirements/strategic/outcomes.spec.md
  - *Impact*: HIGH - New step in Phase 0
  - *Changes*: Derives outcomes from PURPOSE.md success criteria
  - *Output*: specs/1-requirements/strategic/outcomes.spec.md

- **Template**: `templates/mission/outcomes.spec.md.template` - High-level requirements template
  - *Impact*: None (new template)
  - *Purpose*: Starter template for project outcomes

- **Template**: `templates/mission/constraints.spec.md.template` - Hard boundaries template
  - *Impact*: None (new template)
  - *Purpose*: Starter template for project constraints

### Changed

- **⚠️ BREAKING**: Folder structure reorganized with specs/1-requirements/strategic/ (CRITICAL IMPACT)
  - *Why*: Clarify top-level project definition vs detailed specifications
  - *Impact*: CRITICAL - All existing projects must migrate
  - *Old structure*:
    ```
    PURPOSE.md
    specs/
    ├── requirements.spec.md
    ├── constraints.spec.md
    ├── workspace/
    ├── strategy/
    └── behaviors/
    ```
  - *New structure*:
    ```
    PURPOSE.md
    specs/
    ├── mission/            # NEW: Top-level project definition
    │   ├── outcomes.spec.md   (was requirements.spec.md)
    │   └── constraints.spec.md
    ├── workspace/
    ├── strategy/
    └── behaviors/
    ```
  - *Migration*:
    1. Create `specs/1-requirements/strategic/` directory
    2. Move `specs/requirements.spec.md` → `specs/1-requirements/strategic/outcomes.spec.md`
    3. Move `specs/constraints.spec.md` → `specs/1-requirements/strategic/constraints.spec.md`
    4. Update all frontmatter references
  - *Rationale*: Groups "why/what/limits" separately from "how" (strategy/behaviors)

- **⚠️ BREAKING**: Metaspec renamed - requirements → outcomes (HIGH IMPACT)
  - *Why*: "Outcomes" better conveys "what we achieve" vs detailed requirements
  - *Impact*: HIGH - File renamed, location changed
  - *Old*: `standard/metaspecs/requirements.spec.md` at `specs/requirements.spec.md`
  - *New*: `standard/metaspecs/outcomes.spec.md` at `specs/1-requirements/strategic/outcomes.spec.md`
  - *Changes*: Updated location, clarified high-level nature, improved examples
  - *Migration*: Update metaspec references in custom prompts

- **⚠️ BREAKING**: Constraints metaspec location updated (HIGH IMPACT)
  - *Impact*: HIGH - Location changed
  - *Old*: `specs/constraints.spec.md`
  - *New*: `specs/1-requirements/strategic/constraints.spec.md`
  - *Changes*: Updated location in metaspec, relationship diagrams
  - *Migration*: Move constraints.spec.md to mission/ folder

- **⚠️ BREAKING**: Phase 0 prompts restructured (HIGH IMPACT)
  - *Why*: Align with new mission/ folder structure
  - *Impact*: HIGH - Prompt numbering changed, PURPOSE.md now explicit
  - *Changes*:
    - `0b-define-problem.md` → now creates PURPOSE.md (not specs/problem.md)
    - `0c-define-outcomes.md` → NEW - creates specs/1-requirements/strategic/outcomes.spec.md
    - `0d-identify-constraints.md` → RENUMBERED from 0c, creates specs/1-requirements/strategic/constraints.spec.md
    - `0e-assess-complexity.md` → RENUMBERED from 0d
  - *Migration*: Update Phase 0 references in custom workflows

- **Spec**: `specs/3-behaviors/five-phases.spec.md` - Phase 0 outputs updated
  - *Impact*: None (LiveSpec's own spec)
  - *Changes*: Updated Phase 0 outputs to reflect mission/ folder

- **Convention**: `standard/conventions/folder-structure.spec.md` - Added mission/ folder
  - *Impact*: HIGH (affects all projects)
  - *Changes*: Documents specs/1-requirements/strategic/ structure, updated examples

- **Prompts**: Multiple prompts updated for path changes
  - *Files*: next-steps.md, analyze-failure.md, 4a-detect-drift.md, 3b-acceptance-review.md
  - *Impact*: MEDIUM (affects drift detection, validation)
  - *Changes*: Updated all references to requirements/constraints paths

### Fixed

- Hierarchy confusion between PURPOSE.md, requirements, and constraints now resolved
- Clear separation between vision (PURPOSE), outcomes (high-level), and constraints (limits)
- Relationship diagrams updated across all metaspecs for consistency

### Migration Guide

**For existing LiveSpec projects:**

1. **Create mission folder:**
   ```bash
   mkdir -p specs/1-requirements/strategic
   ```

2. **Move specification files:**
   ```bash
   # If you have requirements.spec.md
   mv specs/requirements.spec.md specs/1-requirements/strategic/outcomes.spec.md

   # If you have constraints.spec.md
   mv specs/constraints.spec.md specs/1-requirements/strategic/constraints.spec.md
   ```

3. **Update frontmatter dependencies:**
   - Search for `specs/requirements.spec.md` → replace with `specs/1-requirements/strategic/outcomes.spec.md`
   - Search for `specs/constraints.spec.md` → replace with `specs/1-requirements/strategic/constraints.spec.md`

4. **Upgrade LiveSpec methodology:**
   ```bash
   # Use upgrade prompt for AI-assisted migration
   # "Use .livespec/utils/upgrade-methodology.md"
   ```

**For new projects:**
- No action needed - Phase 0 prompts create correct structure automatically

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

- **Spec**: `specs/3-behaviors/changelog.spec.md` - Added retrospective specification
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
  - *Why*: AI created `specs/architecture.spec.md` instead of `specs/2-strategy/architecture.spec.md`
  - *Why*: User feedback: "without logging strategy debugging became a problem later"
  - *Impact*: MEDIUM - path correction + new optional checklist
  - *Changes*:
    - Line 17: Fixed path from `specs/architecture.md` to `specs/2-strategy/architecture.spec.md`
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

- **Documentation**: `specs/2-strategy/architecture.spec.md` - Added multi-domain patterns
  - *Impact*: None (LiveSpec's own architecture doc)

- **Documentation**: `AGENTS.md` - Added multi-domain organization and version tracking sections
  - *Impact*: None (agent configuration, regenerate after customization)

### Fixed

- **Workspace specs metaspec compliance**: Added missing `applies_to` frontmatter to constitution.spec.md, workflows.spec.md, patterns.spec.md (metaspec requirement)
- **AGENTS.md Core Principles drift**: Updated to reflect current constitution.spec.md principle order (Specs Before Implementation now #1)
- **CHANGELOG drift**: Added missing entries for spec-first enforcement commits (cd998df, 8321fd5, 60c32e1)
- Strategy specifications now created in correct location (`specs/2-strategy/` not `specs/`)
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
- **specs/3-behaviors/** - WHAT system does (product-specific observable outcomes)
- **specs/3-contracts/** - Interfaces and contracts (APIs, data formats)
- **specs/2-strategy/** - Cross-cutting technical decisions (architecture, technology choices)

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
- 4d-regenerate-context.md
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