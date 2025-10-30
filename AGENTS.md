---
generated: 2025-10-27T00:00:00Z
generator: livespec/prompts/4-evolve/4d-regenerate-agents.md
version: 3.1.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, use prompts/4-evolve/4d-regenerate-agents.md
---

> **⚠️ Generated File**: Do not edit directly. See frontmatter for regeneration instructions.

# LiveSpec Agent Configuration

## Summary

This document provides essential LiveSpec knowledge for AI agents. Cache this once per session to handle 90% of LiveSpec operations without repeated context7 lookups.

**Purpose**: Specifications that live with your code - preventing drift between docs and implementation.

**Success Criteria**:
- Specs remain synchronized with code throughout development
- AI agents have structured context for effective assistance
- Documentation stays current without becoming a maintenance burden

---

## ⚠️ CRITICAL: Spec-First Guidance (Principle #1)

**Please guide users through this essential step:**

Before implementing any deliverable (code, prompt, template, documentation, config), check:

### 1. Does specification exist?

```bash
# Check for spec
ls specs/3-behaviors/[deliverable].spec.md 2>/dev/null ||
ls specs/3-contracts/[deliverable].spec.md 2>/dev/null ||
ls specs/2-strategy/[deliverable].spec.md 2>/dev/null
```

**Spec locations:**
- Behaviors (observable outcomes): `specs/3-behaviors/[deliverable].spec.md`
- Contracts (interfaces): `specs/3-contracts/[deliverable].spec.md`
- Strategy (cross-cutting): `specs/2-strategy/[deliverable].spec.md`

### 2. If NO spec exists: Guide to spec creation

**Pause and say:**
> "I need a specification before implementing. Let's create specs/3-behaviors/[deliverable].spec.md first."

**Then guide to Phase 1 (DESIGN):**
- For behaviors: "Use `.livespec/1-design/1b-define-behaviors.md`"
- For contracts: "Use `.livespec/1-design/1c-create-contracts.md`"
- For architecture/strategy: "Use `.livespec/1-design/1a-design-architecture.md`"

### 3. If YES spec exists: Verify & Implement

- Read specification completely
- Verify spec has:
  - Requirements section with [!] items
  - Validation criteria
  - Failure mode defined
- Implement what spec requires

### Common Patterns to Guide

**These all need specs first:**
- "Let's create a CHANGELOG" → Guide to `specs/3-behaviors/changelog.spec.md` first
- "Add a README file" → Guide to `specs/3-behaviors/readme.spec.md` first
- "Write a config template" → Guide to spec creation first
- "This is obvious, no need for spec" → Gently guide: spec needed for all deliverables

### Why This Matters

**Familiarity creates false confidence:**
- "Everyone knows what a CHANGELOG is" (but requirements vary)
- "README is standard" (but what should it contain?)
- "This is obvious" (assumptions cause drift)

**Real example:** LiveSpec's own CHANGELOG was implemented without spec (commit 40411e3), violating this principle. Even methodology creators make this mistake when familiarity overrides discipline.

**Your role:** Guide spec-first development, especially when user wants to skip it. Say: "I understand this seems obvious, but LiveSpec works best when we create a specification first. This prevents drift and ensures requirements are captured. Let's create the spec together - it will be quick."

---

## ⚠️ CRITICAL: Pre-Implementation Verification

Before implementing ANY deliverable (code, prompt, template, documentation, config), verify:

1. ☐ **Behavior spec exists** for this deliverable
   - Check: `specs/3-behaviors/[deliverable].spec.md` exists
   - Spec has Requirements section with [!] items
   - Spec has Validation criteria
   - Spec has Failure Mode defined

2. ☐ **Tests exist** (if TDD project) and currently FAIL (RED)
   - Check: `tests/behaviors/[deliverable].test.ts` exists
   - Tests map to validation criteria (one test per criterion)
   - Tests currently fail (no implementation yet)

3. ☐ **Plan includes methodology steps** (not just implementation)
   - Plan includes spec creation (specific file path)
   - Plan includes test creation if TDD (specific file path)
   - Plan includes TDD cycle if applicable (RED → GREEN → REFACTOR)

**If any checkbox is unchecked → STOP**

Guide user to Phase 1 (DESIGN):
- For behaviors: "Use `.livespec/1-design/1b-define-behaviors.md`"
- For contracts: "Use `.livespec/1-design/1c-create-contracts.md`"
- For architecture/strategy: "Use `.livespec/1-design/1a-design-architecture.md`"

## ⚠️ WARNING: No "Plumbing" Exception

**ALL behavior changes require specifications.** There is no exception for "simple" or "infrastructure" work.

### Red Flags (Mental Categorization Errors)

These phrases indicate you may be skipping necessary specification:
- ❌ "Just wiring up [X]"
- ❌ "Just infrastructure"
- ❌ "Obviously simple"
- ❌ "This is just plumbing"
- ❌ "Everyone knows what [X] is"

### The Test

Ask yourself: **"If this breaks, does something stop working?"**

- **YES** → It's a feature → Needs specification → Needs tests (if TDD)
- **NO** → It's truly implementation detail → May not need spec

### Real Example

LiveSpec's own MCP resource serving was categorized as "just wiring up resources" and implemented without specs. This violated the project's TDD methodology despite having full documentation. The agent had to create a detailed violation report.

**Lesson**: Familiarity creates false confidence. When in doubt, create a spec.

## Active Self-Check Questions

Before implementing, actively ask yourself:

### Spec-First Check
- **"Does this project require specs?"**
  - Check: Does `specs/` directory exist?
  - Check: Does `specs/workspace/constitution.spec.md` mention spec-first?

- **"Does a spec exist for what I'm implementing?"**
  - Check: `ls specs/3-behaviors/[deliverable].spec.md`
  - If NO → Guide to Phase 1 (DESIGN)

### TDD Check
- **"Does this project use TDD?"**
  - Check: Read `specs/workspace/workflows.spec.md`
  - Look for: TDD cycle, test-first requirements

- **"Have I written tests before implementation?"**
  - Check: `ls tests/behaviors/[deliverable].test.ts`
  - Tests should exist and FAIL before implementation

### Methodology Compliance
- **"Am I following the documented methodology?"**
  - Check: Read `specs/workspace/` files
  - Verify: My plan matches documented workflows

- **"Have I verified my plan follows methodology?"**
  - Before user approval, check plan includes:
    - Spec creation (if needed)
    - Test creation (if TDD)
    - Methodology steps (not just implementation)

### Meta-Check
- **"Am I in execution mode bypassing methodology?"**
  - Warning sign: Focused on "completing the plan" rather than "following methodology"
  - Pause: Re-verify methodology compliance before continuing

## Plan Review for Methodology Compliance

When presenting plans to users, include explicit methodology compliance verification:

### Before User Approval

Verify and report:

**☐ Spec Creation**
- [ ] Does plan include creating/updating spec?
- [ ] Specific file path listed: `specs/3-behaviors/[feature].spec.md`
- [ ] If spec already exists, is it listed as "read and verify"?

**☐ Test Creation (if TDD project)**
- [ ] Does plan include writing tests FIRST?
- [ ] Specific file path listed: `tests/behaviors/[feature].test.ts`
- [ ] TDD cycle explicit: "Write tests (RED) → Implement (GREEN) → Refactor"

**☐ Methodology Steps vs Implementation Steps**
- [ ] Plan describes methodology process (spec → test → implement)
- [ ] Plan NOT just implementation steps ("create directory", "implement handlers")

**☐ Workflow Reference**
- [ ] Plan references project's documented workflow
- [ ] Plan follows phases defined in `specs/workspace/workflows.spec.md`

### Report to User

**Before execution**, present compliance status:

```markdown
## Methodology Compliance Check

☐ Specification: [EXISTS/WILL CREATE: path] / [MISSING - need to create first]
☐ Tests: [EXISTS/WILL CREATE: path] / [N/A - not TDD project] / [MISSING - need to create first]
☐ Workflow: Follows [reference specific workflow from specs/workspace/]

[If non-compliant: "I need to revise this plan to include [missing items] first."]
[If compliant: "This plan follows project methodology. Ready to proceed with your approval."]
```

### After User Approval

Before beginning execution, re-verify one final time that all methodology artifacts are in place or explicitly included in approved plan.

---

## Core Principles (In Priority Order)

**From specs/workspace/constitution.spec.md:**

### 1. Specs Before Implementation
- Every deliverable requires specification before implementation
- AI agents check for spec existence and guide to Phase 1 (DESIGN) if missing
- Applies to all deliverables (code, prompts, templates, documentation, configs)
- Even "obvious" deliverables need specs (CHANGELOG mistake in commit 40411e3)
- See "⚠️ CRITICAL: Spec-First Guidance" section above for detailed workflow

### 2. MSL Minimalism
- Specs justify their existence (would system fail without this?)
- Specify WHAT, not HOW
- Only CRITICAL or IMPORTANT requirements
- Trust implementers for details
- **Note**: All LiveSpec artifacts are specifications at different abstraction levels. "Requirements" in folder names (1-requirements/) refers to strategic specifications (high-level WHAT), not a separate document category. All use MSL format.
- **See Reference Library**: `msl-minimalism.md` for complete decision framework

### 3. Dogfooding
- LiveSpec uses its own methodology
- Repository has specs/ and prompts/
- No custom tooling required

### 4. Simplicity Over Features
- No custom tooling (works with file operations and AI prompts only)
- Standard markdown format, standard folder structure
- Don't over-prescribe implementation details
- Define edges, not paths
- Innovation happens in unspecified spaces

### 5. Living Documentation
- Specs evolve continuously with code
- Phase 4 (EVOLVE) runs regularly to detect drift
- Extract new behaviors as they emerge
- Update specs alongside code changes

### 6. Governance Framework Awareness
- LiveSpec is specialized for governance/methodology documentation
- Patterns demonstrated here apply to governance domain specifically
- Extensions documented as domain-specific, not universal patterns

### 7. Active Agent Guidance
- AGENTS.md is definitive cacheable agent context (<100KB)
- 80/20 coverage (agents handle 80% of cases without fetching additional context)
- Includes ACTIVE verification prompts (not passive documentation)
- Context positioning optimized (START 30-40%, MIDDLE 40%, END 20-30%)
- Clear pointers to extended context (when to fetch full prompts)
- Templates in `.livespec/templates/agents/` provide reusable verification content
- Structural enforcement makes compliance path of least resistance

## Context Compression

**What it is**: Active force that reorganizes guidance layer (workspace/, AGENTS.md, templates) for agent focus efficiency.

**Complements MSL Minimalism**:
- **MSL Minimalism**: Content pressure (reduce within specs - WHAT/requirements)
- **Context Compression**: Structural force (reorganize across guidance - HOW agents consume)

**This project uses**: Moderate compression (balanced inline/reference)
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Templates for repeated verification patterns
- Target size: 70-85KB

**Three levels**:
- **Light**: Verbose, self-contained (exploratory work, large context agents)
- **Moderate**: Balanced (production, most agents) ← **Current**
- **Aggressive**: Dense, focused (cost-sensitive, high-frequency usage)

**Configuration**: Declared in `specs/workspace/constitution.spec.md` frontmatter (`context_compression: moderate`)

**Change level**: Use `.livespec/prompts/utils/audit-context-compression.md` to measure and migrate

**See Reference Library**: `context-compression.spec.md` for full framework

## Project Taxonomy (Check First)

**CRITICAL**: Before creating ANY files, check `specs/workspace/taxonomy.spec.md`

This project-level classification defines three essential boundaries:

1. **Project Domain**: What type of project this is
   - Software (code → executables)
   - Generation (data → tailored deliverables like CVs, reports)
   - Planning (research → decisions/analyses)
   - Documentation (specs → published docs)
   - Governance (methodology → framework)
   - Hybrid (combination of above)

2. **Workspace Scope**: What's portable methodology vs product-specific
   - Explicitly lists workspace/ contents (typically: constitution, patterns, workflows, taxonomy)
   - Explicitly states what's NOT workspace with examples
   - Test: "Could I use this in ANY project?" → YES = workspace/, NO = elsewhere

3. **Specs Boundary**: Declares "specs/ = specifications only"
   - No user data in specs/ (data → data/ folder)
   - No research materials in specs/ (research → research/ folder)
   - No generated artifacts in specs/ (outputs → generated/ or var/generated/)
   - specs/ defines WHAT to do, never contains actual data or outputs

**Common mistakes taxonomy prevents**:
- ❌ Putting product features in workspace/ (fails portability test)
  - Example: "job-applications.spec.md" in workspace/ → Should be 3-behaviors/processes/
- ❌ Putting user data in specs/ (violates specs boundary)
  - Example: CV details in specs/ → Should be in data/ folder
- ❌ Creating files without checking project classification
  - Always check taxonomy FIRST, then apply patterns

**Decision order when creating files**:
1. Read `specs/workspace/taxonomy.spec.md` (primary reference)
2. Apply classification rules from taxonomy
3. Check `specs/workspace/patterns.spec.md` for naming conventions
4. If still unclear, use portability test ("works in any project?" → workspace/)

**See Reference Library**: `taxonomy.spec.md` metaspec for complete framework

## Constraints (Critical Boundaries)

### Agent Agnostic
Works with any AI coding agent (Claude, Copilot, Cursor, etc.). Same structure produces effective results across 3+ agents.

### Manual Adoption
Simple enough to adopt without custom tooling. Users can set up with standard file operations and AI prompts only.

### MSL Minimalism
All specifications follow MSL principles. Specifications cannot be further reduced without losing essential information.

### No Framework Lock-in
Pure information architecture. Specs are readable markdown, folder structure is standard, no custom parsers required.

### Testable Behaviors
All behaviors are observable and verifiable. Every specification includes concrete validation criteria.

---

## Quick Start (80% of Cases)

### New Project
```bash
# 1. Copy LiveSpec methodology
cp -r livespec/dist/ .livespec/

# 2. Create specs structure
mkdir -p specs/{workspace,mission,strategy,behaviors,contracts}

# 3. Create PURPOSE.md
echo "# Project Purpose

## Why This Exists
[Problem this project solves]

## What Success Looks Like
[Measurable success criteria]" > PURPOSE.md

# 4. Start Phase 0 (choose one):
# Quick start (5 min, zero questions): "Use .livespec/0-define/0a-quick-start.md"
# Full customization (20-30 min): "Use .livespec/0-define/0b-customize-workspace.md"
```

### Existing Project
```bash
# Extract specifications from code
# "Use .livespec/4-evolve/4b-extract-specs.md to document this codebase"
```

## Decision Tree

```
What do you need to do?
│
├─ **New project?**
│  ├─ Quick (5 min): Use .livespec/0-define/0a-quick-start.md
│  └─ Customize (20-30 min): Use .livespec/0-define/0b-customize-workspace.md
│
├─ **Existing project without specs?**
│  └─ Phase 4: Use .livespec/4-evolve/4b-extract-specs.md
│
├─ **Code and specs drifted?**
│  └─ Phase 4: Use .livespec/4-evolve/4a-detect-drift.md
│
├─ **Need to design new feature?**
│  └─ Phase 1: Use .livespec/1-design/1a-design-architecture.md
│
├─ **Ready to implement?**
│  └─ Phase 2: Use .livespec/2-build/2a-implement-from-specs.md
│
└─ **Need validation?**
   └─ Phase 3: Use .livespec/3-verify/3a-run-validation.md
```

## The 5 Phases

### Phase 0: DEFINE
Establish problem space and constraints.

**When**: Starting new project or documenting existing one
**Entry**: Project idea or codebase
**Exit**: Problem, constraints, workspace defined
**Outputs**: PURPOSE.md, specs/1-requirements/strategic/constraints.spec.md, specs/workspace/
**Key Prompts**:
- `0a-quick-start.md` - Zero-question setup (5 min, defaults)
- `0b-customize-workspace.md` - Full workspace customization
- `0c-define-problem.md` - Articulate problem statement
- `0d-define-outcomes.md` - Define high-level requirements
- `0e-assess-complexity.md` - Evaluate project complexity
- `0f-evaluate-research-needs.md` - Determine if UX research needed
- `0g-identify-constraints.md` - Document boundaries

### Phase 1: DESIGN
Design solution architecture.

**When**: After problem clear, before implementation
**Entry**: Problem and constraints defined
**Exit**: Architecture and contracts specified
**Outputs**: specs/2-strategy/architecture.spec.md, specs/3-behaviors/, specs/contracts/
**Key Prompts**:
- `1a-design-architecture.md` - Define system structure
- `1b-define-behaviors.md` - Specify observable outcomes
- `1c-create-contracts.md` - Define API/data interfaces

### Phase 2: BUILD
Implement the solution.

**When**: After design approved
**Entry**: Design specifications complete
**Exit**: Implementation matches specifications
**Outputs**: Code + tests satisfying specs
**Key Prompts**:
- `2a-implement-from-specs.md` - Build from specifications
- `2b-create-tests.md` - Create validation tests

**See Reference Library**: `tdd.md` for complete test-driven development process

### Phase 3: VERIFY
Validate solution meets requirements.

**When**: After implementation complete
**Entry**: Implementation done
**Exit**: All behaviors validated
**Outputs**: Test results, validation reports
**Key Prompts**:
- `3a-run-validation.md` - Execute validation tests
- `3b-acceptance-review.md` - Stakeholder approval

### Phase 4: EVOLVE
Keep specs and code synchronized (continuous).

**When**: Ongoing throughout development
**Entry**: System in production or active development
**Exit**: Continuous (loop back to other phases as needed)
**Outputs**: Updated specifications, drift reports
**Key Prompts**:
- `4a-detect-drift.md` - Identify spec-code misalignment
- `4b-extract-specs.md` - Generate specs from code
- `4c-sync-complete.md` - Confirm synchronization
- `4d-regenerate-agents.md` - Update AGENTS.md
- `4e-validate-extractions.md` - Review extracted specs

## MSL Format Quick Reference

All specifications use [MSL (Markdown Specification Language)](https://github.com/chrs-myrs/msl-specification):

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks without this]
---

# [Feature/Component Name]

## Requirements
- [!] [Concise description of WHAT is required, not HOW]
  - [Testable criterion 1]
  - [Testable criterion 2]
  - [Testable criterion 3]
```

**That's it.** Title, frontmatter, Requirements. Keep specifications minimal.

## Folder Structure Pattern

```
your-project/
├── PURPOSE.md              # Why this exists, what success looks like
│
├── .livespec/              # Copied from livespec/dist/
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   ├── 4-evolve/
│   ├── utils/              # Utility prompts
│   ├── standard/           # MSL metaspecs
│   └── templates/          # Workspace and agent templates
│
└── specs/
    ├── workspace/          # HOW you build (process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── 1-requirements/     # WHY and strategic/functional requirements
    │   ├── strategic/      # High-level outcomes, constraints
    │   │   ├── outcomes.spec.md
    │   │   └── constraints.spec.md
    │   └── functional/     # Specific feature requirements
    │
    ├── 2-strategy/         # HOW you solve (approach)
    │   └── architecture.spec.md
    │
    ├── 3-behaviors/        # WHAT system does (observable outcomes)
    └── 3-contracts/        # API/data contracts
```

## Folder Organization Decision Tests

**Critical for proper spec placement:**

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check 1-requirements/, 2-strategy/, or 3-behaviors/

**1-requirements/ test:** "Is this a strategic outcome or hard constraint?"
- YES, strategic → 1-requirements/strategic/ (outcomes, constraints)
- YES, functional → 1-requirements/functional/ (specific feature requirements)
- NO → Check 2-strategy/ or 3-behaviors/

**2-strategy/ test:** "Does this apply across the whole product?"
- YES → 2-strategy/ (cross-cutting technical decision)
- NO → Check 3-behaviors/

**3-behaviors/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → 3-behaviors/ (what system does)
- NO → Re-examine classification

**Common Mistakes:**
- ❌ "API returns JSON" → NOT workspace (product-specific) → 2-strategy/
- ❌ "Use 4-space indentation" → NOT 2-strategy/ (not critical) → workspace/ (if it matters)
- ❌ "System authenticates users" → NOT 2-strategy/ (observable) → 3-behaviors/

**Correct Examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (applies to any project)
- ✅ "API responses must be JSON" → 2-strategy/architecture.spec.md (product-wide decision)
- ✅ "System authenticates users via OAuth" → 3-behaviors/authentication.spec.md (observable outcome)

**See Reference Library**: `folder-structure.spec.md` for detailed classification tests

## Multi-Domain Organization (v2.1+)

**Key insight:** behaviors/ and contracts/ abstractions work across ALL domains. Use subfolders for semantic organization.

### Domain-Agnostic Abstractions

**behaviors/** = Observable outcomes from any perspective:
- Software: "System authenticates users"
- Governance: "Only authorized entities access resources" (policy)
- Operations: "Backups complete daily" (service)
- Planning: "Feature meets success criteria" (requirement)

**contracts/** = Interface definitions of any kind:
- Software: API contracts (`GET /users/{id}`)
- Governance: Process contracts (procedures)
- Operations: Operational contracts (runbooks)
- Planning: Workflow contracts (delivery processes)

### Organization Patterns by Domain

**Software projects:**
```
specs/
├── workspace/           # How we work
├── 1-requirements/      # Strategic and functional requirements
├── 2-strategy/          # Cross-cutting decisions
├── 3-behaviors/
│   ├── user-features/  # User-facing behaviors
│   └── system/         # System behaviors
└── 3-contracts/
    └── api/v1/         # API contracts
```

**Hybrid projects:**
```
specs/
├── workspace/             # How we work
├── 1-requirements/        # Strategic and functional requirements
├── 2-strategy/            # Cross-cutting (all domains)
├── 3-behaviors/
│   ├── user-features/    # Software
│   ├── policies/         # Governance
│   └── services/         # Operations
└── 3-contracts/
    ├── api/              # Software
    ├── procedures/       # Governance
    └── runbooks/         # Operations
```

## Essential Templates

### Workspace Constitution
```markdown
# [Project Name] Development Constitution

**Criticality**: CRITICAL
**Failure Mode**: Development becomes inconsistent

## Requirements
[3-5 core development principles for this project]

## Validation
- [Observable behaviors demonstrating adherence]
```

### Behavior Specification
```markdown
# [Feature Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [Impact if missing]

## Requirements
[Observable behavior the system must exhibit]

## Validation
- [How to verify this works]
- [Edge cases to test]
```

### API Contract
```markdown
# [Endpoint Name]

**Criticality**: CRITICAL
**Failure Mode**: [Integration breaks]

## Requirements
[Request/response format, authentication, rate limits]

## Validation
- [Valid requests succeed]
- [Invalid requests fail appropriately]
```

### Extracted Specification (Low Confidence)
```markdown
---
extracted_from:
  - src/cache/redis.py
extracted_date: 2025-10-06
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from implementation, no tests found"
---

# Cache Invalidation

**Criticality**: IMPORTANT (estimated)
**Failure Mode**: Stale data served to users (inferred)

## Requirements

⚠️ **EXTRACTION NOTES**: TTL constant found in code. No tests for invalidation behavior. Actual requirement unclear.

System appears to invalidate Redis cache entries after 1 hour TTL.

## Validation

**Status**: EXTRACTED - Requires validation

- [?] Cache TTL is 1 hour (constant found: CACHE_TTL = 3600)
- [?] Cache invalidates on entity updates (invalidation code present)
- [?] Cache misses fetch from database (fallback logic exists)

**Review checklist:**
- [ ] Confirm 1-hour TTL is requirement (vs implementation detail)
- [ ] Verify invalidation triggers
- [ ] Add test coverage for cache behavior
```

## Specification Dependencies

LiveSpec specs form a **dependency graph**, not a hierarchy:
- **Vertical**: PURPOSE → requirements (HLR) → design → implementation → code
- **Horizontal**: Workspace (process) applies across all levels

### Dependency Structure

**Key insight:** Implementation specs have **dual linkage** (not pure cascade):

```
PURPOSE.md (Why - Vision)
  ↓ defines
specs/1-requirements/strategic/outcomes.spec.md (What - High-Level Requirements)
  ↓ derives-from                           ↓ derives-from
specs/2-strategy/architecture.spec.md ←──────┐
  ↓ guided-by (HOW)                          │
  │                                          │
  ├──→ specs/3-behaviors/*.spec.md ──────────┘
  │      ↑ satisfies (WHAT)
  │      │
  └──────┘
         ↓ implemented-by
      code (Implementation)
```

**Dual relationships in implementation specs:**
- **satisfies** (vertical): Links directly to requirements (WHAT business value)
- **guided-by** (horizontal): Follows strategic approach (HOW implemented)

**Example:**
```yaml
# specs/3-behaviors/payment-processing.spec.md
---
satisfies:
  - specs/1-requirements/functional/transaction-accuracy.spec.md  # WHAT
guided-by:
  - specs/2-strategy/api-design.spec.md                          # HOW
---
```

**Orthogonal (applies everywhere):**
- `specs/workspace/` - Process governing all development

### Frontmatter Convention

Specs declare dependencies via YAML frontmatter:

```yaml
---
derives-from:
  - PURPOSE.md
  - specs/1-requirements/strategic/outcomes.spec.md
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
---
```

**Fields:**
- `derives-from` - Parent specs this is based on
- `governed-by` - Boundaries this must respect
- `satisfies` - Requirements this fulfills (vertical - WHAT)
- `guided-by` - Strategies that guide this spec (horizontal - HOW)
- `supports` - What this spec enables
- `applies_to` - Scope (for workspace specs)

### ⚠️ Critical: Dual Linkage Pattern

**Common mistake:** Assuming pure cascade (Requirements → Strategy → Behaviors)

**❌ Wrong mental model:**
```
Behaviors satisfy strategy, strategy satisfies requirements
```

**✅ Correct model:**
```
Behaviors SATISFY requirements (direct link - WHAT they achieve)
Behaviors GUIDED-BY strategy (horizontal influence - HOW they do it)
```

**Why this matters:**
- Enables rapid rebuild: Same requirements, different strategy, new implementation
- Technology-agnostic requirements: Requirements don't change when replatforming
- Clear traceability: What business value (satisfies) vs how implemented (guided-by)

**Real example confusion:** Agent sees behavior linking directly to requirement and flags as "missing strategy layer." This is CORRECT behavior - behaviors should satisfy requirements directly while being guided by strategy.

**See full explanation:** `specs/2-strategy/three-layer-architecture.spec.md` (section: "Dual Linkage Pattern")

**See Reference Library**: `dependencies.spec.md` for complete frontmatter conventions

## Common Anti-Patterns

❌ **Skipping Phase 0**
```
Bad:  Jump straight to coding
Good: Create PURPOSE.md and workspace specs first
```

❌ **Over-specification**
```
Bad:  "Button must be exactly 120px wide with #007bff color"
Good: "Submit button must be clearly visible"
```

❌ **Ignoring Drift**
```
Bad:  Let specs and code diverge over months
Good: Run Phase 4 drift detection weekly/before releases
```

❌ **Wrong Criticality**
```
Bad:  Everything marked CRITICAL
Good: Only truly critical requirements marked CRITICAL
```

## Bidirectional Linking

LiveSpec uses YAML frontmatter for bidirectional links:

**In prompts:**
```markdown
---
implements: specs/3-behaviors/prompts/0a-quick-start.spec.md
---
```

**In specs:**
```markdown
---
specifies: dist/prompts/0-define/0a-quick-start.md
---
```

This enables AI agents to navigate between prompts and their specifications.

## Development Patterns

**From specs/workspace/patterns.spec.md:**

- All specs use MSL format (.spec.md extension: title, frontmatter, Requirements section)
- British English for user docs (synchronisation, behaviour)
- Phase-letter naming for prompts (0a-, 1b-, 2c-)
- One spec per behavior
- Workspace/strategy separation in folder structure
- Cross-reference updates require systematic checklist (see below)

### Cross-Reference Update Pattern

When renaming or moving prompts or specs, use systematic checklist to maintain traceability:

**Files to update:**
- [ ] Source file renamed/moved (dist/prompts/ or specs/)
- [ ] Spec frontmatter (`specifies:` or `implements:` field)
- [ ] Registry entry (specs/3-behaviors/prompts/registry.spec.md)
- [ ] Navigation files (dist/prompts/utils/next-steps.md)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (prompts/utils/validate-project.md)

**Why systematic approach matters:**
- Missing spec frontmatter breaks bidirectional linking
- Missing registry breaks prompt discovery
- Missing navigation breaks workflow guidance
- Validation catches errors before commit

### Architecture Documentation Pattern

When documenting architectural decisions, capture multiple dimensions:

**Implementation Benefits** (developer experience):
- Code organisation clarity
- Developer productivity
- Maintainability approach
- Testing strategy

**Strategic Benefits** (business value):
- Business value delivered
- Cost implications
- Risk reduction mechanisms
- Competitive advantages
- Technology flexibility

**Why both matter:**
- Strategic benefits drive adoption (business case)
- Implementation benefits drive success (developer experience)
- Documentation needs both for complete picture

**Example: Three-Layer Architecture**

Implementation benefits:
- Clear separation of concerns (WHAT/HOW/EXACTLY)
- Testable requirements independent of implementation
- Traceability from requirements through to code

Strategic benefits:
- Rapid rebuild on different technology stacks (microservices flexibility)
- Technology evolution without specification rework
- Cost reduction (no requirements rediscovery during replatforms)
- Microservices pattern enablement (different services, different technologies, same requirements)

## Development Workflows

**From specs/workspace/workflows.spec.md:**

- New prompts require behavior specs first
- Spec changes follow EVOLVE phase workflow
- Changes validated through real usage before merge
- Periodic MSL audits maintain minimalism
- Documentation updates accompany prompt/spec changes
- Spec-first guidance workflow precedes all implementation
- Learning distribution flows through templates → specs → prompts → AGENTS.md → dist/

### Prompt Reorganisation Workflow

When adding new prompts between existing prompts or renumbering:

**Phase 1: Plan Renumbering**
1. Identify insertion point in workflow sequence
2. Determine which existing prompts shift (e.g., 0d→0f, 0e→0d)
3. Verify new sequence maintains workflow logic

**Phase 2: Systematic Updates**
1. Rename prompt files in dist/prompts/[phase]/
2. Update spec frontmatter (specifies: field in specs/3-behaviors/prompts/)
3. Update registry (specs/3-behaviors/prompts/registry.spec.md table)
4. Update navigation (dist/prompts/utils/next-steps.md decision tree)
5. Update predecessor prompts ("Next Step" sections)
6. Update AGENTS.md references if prompt mentioned

**Phase 3: Validation**
1. Run cross-reference validation (prompts/utils/validate-project.md)
2. Check all references resolve correctly
3. Verify workflow sequence makes logical sense
4. Test prompt discovery (can agents find renamed prompts?)

**Common mistakes:**
- Forgetting spec frontmatter updates (breaks bidirectional linking)
- Missing next-steps.md references (breaks navigation)
- Breaking workflow logic with poor insertion point

## Reference Library (Deep Detail Navigation)

AGENTS.md provides 80% coverage. For deep detail, fetch these references using `.livespec/` paths:

### Conventions (How to Structure)

**Context Compression** - `.livespec/standard/conventions/context-compression.spec.md`
- **Fetch when**: Deciding inline vs extract, optimizing AGENTS.md size, migrating compression levels
- **Provides**: Full compression framework, decision criteria, extraction patterns
- **Cross-ref**: See "Context Compression" section for summary

**Folder Structure** - `.livespec/standard/conventions/folder-structure.spec.md`
- **Fetch when**: Creating spec folders, unclear where file belongs, multi-domain organization
- **Provides**: Folder organization tests, workspace vs strategy vs behaviors classification
- **Cross-ref**: See "Folder Organization Decision Tests" section

**Dependencies** - `.livespec/standard/conventions/dependencies.spec.md`
- **Fetch when**: Managing spec relationships, frontmatter links, dependency graphs
- **Provides**: Frontmatter conventions, bidirectional linking, dependency types
- **Cross-ref**: See "Specification Dependencies" section

**Naming Conventions** - `.livespec/standard/conventions/naming.spec.md`
- **Fetch when**: Creating files, unsure of naming pattern, standardizing extensions
- **Provides**: File naming patterns, extension conventions, phase-letter naming

### Metaspecs (Templates for Spec Types)

**Prompt** - `.livespec/standard/metaspecs/prompt.spec.md`
- **Fetch when**: Writing new prompts, creating Phase 0-4 workflows

**Behavior** - `.livespec/standard/metaspecs/behavior.spec.md`
- **Fetch when**: Writing behavior specs, defining observable outcomes

**Contract** - `.livespec/standard/metaspecs/contract.spec.md`
- **Fetch when**: Writing API/data contracts, defining interfaces

**Workspace** - `.livespec/standard/metaspecs/workspace.spec.md`
- **Fetch when**: Creating workspace specs, defining project governance

**Others**: `base.spec.md`, `constraints.spec.md`, `outcomes.spec.md`, `purpose.spec.md`, `strategy.spec.md`

### Guides (How to Apply)

**MSL Minimalism** - `.livespec/guides/msl-minimalism.md`
- **Fetch when**: Spec too verbose, applying minimalism framework, auditing requirements
- **Provides**: Complete MSL decision framework, requirement hierarchy
- **Cross-ref**: See "MSL Minimalism" principle

**TDD** - `.livespec/guides/tdd.md`
- **Fetch when**: Implementing TDD workflow, writing tests before code
- **Provides**: Complete TDD process, spec-to-test mapping
- **Cross-ref**: See Phase 2 (BUILD)

**Context Positioning** - `.livespec/guides/context-positioning.md`
- **Fetch when**: Optimizing AGENTS.md structure, START/MIDDLE/END pattern
- **Provides**: Research-backed positioning framework

**AI Commits** - `.livespec/guides/ai-commits.md`
- **Fetch when**: Creating git commits, following commit standards
- **Provides**: Commit message format, Git safety protocol

### Navigation Pattern

When AGENTS.md mentions a topic, look for "See Reference Library: [file]" to find detailed spec.

---

## When to Fetch Full Prompts

Cache this document, but fetch full prompts when you need:

| Need | Fetch | When |
|------|-------|------|
| Quick start | `.livespec/0-define/0a-quick-start.md` | New project (fast, defaults) |
| Customize workspace | `.livespec/0-define/0b-customize-workspace.md` | New project (full customization) |
| Define problem | `.livespec/0-define/0c-define-problem.md` | Problem unclear |
| Define outcomes | `.livespec/0-define/0d-define-outcomes.md` | High-level requirements |
| Assess complexity | `.livespec/0-define/0e-assess-complexity.md` | Timeline planning |
| Evaluate research | `.livespec/0-define/0f-evaluate-research-needs.md` | Determine if UX research needed |
| Identify constraints | `.livespec/0-define/0g-identify-constraints.md` | Need boundaries |
| Design architecture | `.livespec/1-design/1a-design-architecture.md` | Before implementation |
| Define behaviors | `.livespec/1-design/1b-define-behaviors.md` | Specify features |
| Create contracts | `.livespec/1-design/1c-create-contracts.md` | API/data interfaces |
| Implement | `.livespec/2-build/2a-implement-from-specs.md` | Building features |
| Create tests | `.livespec/2-build/2b-create-tests.md` | Validating code |
| Run validation | `.livespec/3-verify/3a-run-validation.md` | Testing completeness |
| Acceptance review | `.livespec/3-verify/3b-acceptance-review.md` | Stakeholder approval |
| Detect drift | `.livespec/4-evolve/4a-detect-drift.md` | Periodic sync check |
| Extract specs | `.livespec/4-evolve/4b-extract-specs.md` | Existing codebase |
| Sync complete | `.livespec/4-evolve/4c-sync-complete.md` | Confirm alignment |
| Regenerate agents | `.livespec/4-evolve/4d-regenerate-agents.md` | Update AGENTS.md |
| Validate extractions | `.livespec/4-evolve/4e-validate-extractions.md` | Review low-confidence specs |
| **Upgrade LiveSpec** | `.livespec/utils/upgrade-methodology.md` | **New version released** |
| Next steps | `.livespec/utils/next-steps.md` | Workflow navigation |
| Run spike | `.livespec/utils/run-spike.md` | Time-boxed exploration |
| Analyze failure | `.livespec/utils/analyze-failure.md` | Adoption issues |

**Important for upgrades:** The upgrade-methodology.md prompt includes mandatory pre-flight checks and proof-of-work requirements. You must:
- Actually clone the LiveSpec repository (show git clone output)
- Create backup and prove it exists (show ls output)
- Run self-validation tests and show results
- Cannot fake the process - evidence required for each phase

## Workspace Specs Guide AI

The three workspace specs define HOW this specific project is built:

- **constitution.spec.md** - Development principles and governance
- **patterns.spec.md** - Code and specification patterns
- **workflows.spec.md** - Development process workflows

**Always read workspace specs first** when working on a project. They contain project-specific conventions and constraints.

## Version Tracking and Customizations (v2.1+)

### Version Tracking Files

Projects using LiveSpec v2.1+ include version tracking for safe upgrades:

- **`.livespec-version`** - Installed LiveSpec version (enables upgrade detection)
- **`customizations.yaml`** - Tracks user customizations for AI-assisted merges

### Upgrade Workflow

Use `.livespec/utils/upgrade-methodology.md` for AI-assisted upgrades:
- AI reads `customizations.yaml` to identify custom vs canonical files
- Progressive merge: auto-update safe files, interactive review for customized files
- AI explains changes, helps merge conflicts intelligently
- Backup created before upgrade, rollback instructions provided

## Quick Examples by Use Case

### Starting Fresh
```bash
# Copy methodology
cp -r livespec/dist/ .livespec/

# Create structure
mkdir -p specs/{workspace,mission,strategy,behaviors,contracts}

# Use first prompt (choose one):
# Quick: "Use .livespec/0-define/0a-quick-start.md"
# Customize: "Use .livespec/0-define/0b-customize-workspace.md"
```

### Documenting Existing Code
```bash
# Use extract prompt on existing codebase
# "Use .livespec/4-evolve/4b-extract-specs.md to document this codebase"
```

### Checking for Drift
```bash
# Run drift detection
# "Use .livespec/4-evolve/4a-detect-drift.md"
```

### Designing New Feature
```bash
# Use design prompts
# "Use .livespec/1-design/1b-define-behaviors.md for [feature]"
```

## Integration with Context7

When using Context7:
```bash
# Fetch LiveSpec methodology remotely
"Use @context7/chrs-myrs/livespec methodology"
```

Context7 will provide:
- This AGENTS.md file (cache it!)
- Full prompt files as needed
- MSL guide
- Examples

## Final Notes

LiveSpec is just folders and markdown. The methodology guides AI agents to:

1. **Create proper specifications** (Phase 0-1)
2. **Implement from specs** (Phase 2)
3. **Validate correctness** (Phase 3)
4. **Keep specs synchronized** (Phase 4)

Remember: **Start simple, add complexity only when needed. Trust the phases.**

**Context Positioning Design**: This document follows START/MIDDLE/END structure optimized for AI processing. Critical rules and spec-first guidance appear in START section (primacy bias). Detailed examples and procedures in MIDDLE section. Prompt registry and navigation in END section (recency bias). This design maximizes agent compliance with methodology.

---
*Agent configuration for [LiveSpec v3.1.0](https://github.com/chrs-myrs/livespec) - Generated 2025-10-27*
