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
  - *Migration*: Run `prompts/4-evolve/4d-regenerate-agents.md` to apply new enforcement

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
    1. Run `prompts/4-evolve/4d-regenerate-agents.md` (reads new template)
    2. Regenerated AGENTS.md will use 4-layer enforcement
    3. Old templates archived, not deleted (rollback possible)

- **⚠️ Regeneration prompt updated** (MEDIUM IMPACT)
  - `prompts/4-evolve/4d-regenerate-agents.md` now inserts single template
  - `dist/prompts/4-evolve/4d-regenerate-agents.md` updated to match
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
  - Integration in regeneration prompt (`4d-regenerate-agents.md`) applies compression during AGENTS.md generation
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
  - `dist/prompts/4-evolve/4d-regenerate-agents.md` reads compression from constitution
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
    - Updated references in: AGENTS.md, dist/AGENTS.md, patterns.spec.md, outcomes.spec.md, 4d-regenerate-agents.spec.md, 4d-regenerate-agents.md, internalise-learnings.md
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