---
spec: specs/workspace/agents.spec.md
generated: 2025-10-05T11:10:07Z
generator: livespec/generate-project-config
version: 2.0.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, use prompts/4-evolve/4d-regenerate-agents.md
---

# LiveSpec Agent Configuration

## Summary

This document provides essential LiveSpec knowledge for AI agents. Cache this once per session to handle 90% of LiveSpec operations without repeated context7 lookups.

**Purpose**: Specifications that live with your code - preventing drift between docs and implementation.

**Success Criteria**:
- Specs remain synchronized with code throughout development
- AI agents have structured context for effective assistance
- Documentation stays current without becoming a maintenance burden

## Quick Start (80% of Cases)

### New Project
```bash
# 1. Copy LiveSpec methodology
cp -r livespec/prompts .livespec

# 2. Create specs structure
mkdir -p specs/{workspace,behaviors,contracts}

# 3. Create PURPOSE.md
echo "# Project Purpose

## Why This Exists
[Problem this project solves]

## What Success Looks Like
[Measurable success criteria]" > PURPOSE.md

# 4. Start Phase 0
# "Use .livespec/0-define/0a-setup-workspace.md"
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
│  └─ Phase 0: Use .livespec/0-define/0a-setup-workspace.md
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
**Outputs**: PURPOSE.md, specs/constraints.spec.md, specs/workspace/
**Key Prompt**: `0a-setup-workspace.md`

### Phase 1: DESIGN
Design solution architecture.

**When**: After problem clear, before implementation
**Entry**: Problem and constraints defined
**Exit**: Architecture and contracts specified
**Outputs**: specs/behaviors/, specs/contracts/
**Key Prompt**: `1a-design-architecture.md`

### Phase 2: BUILD
Implement the solution.

**When**: After design approved
**Entry**: Design specifications complete
**Exit**: Implementation matches specifications
**Outputs**: Code + tests satisfying specs
**Key Prompt**: `2a-implement-from-specs.md`

### Phase 3: VERIFY
Validate solution meets requirements.

**When**: After implementation complete
**Entry**: Implementation done
**Exit**: All behaviors validated
**Outputs**: Test results, validation reports
**Key Prompt**: `3a-run-validation.md`

### Phase 4: EVOLVE
Keep specs and code synchronized (continuous).

**When**: Ongoing throughout development
**Entry**: System in production or active development
**Exit**: Continuous (loop back to other phases as needed)
**Outputs**: Updated specifications, drift reports
**Key Prompt**: `4a-detect-drift.md`

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
│   └── templates/          # Workspace templates
│
└── specs/
    ├── workspace/          # HOW you build (process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── behaviors/          # WHAT system does
    ├── contracts/          # API/data contracts
    └── constraints.spec.md # Hard boundaries
```

## Folder Organization Decision Tests

**Critical for proper spec placement:**

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check strategy/ or behaviors/

**strategy/ test:** "Does this apply across the whole product?"
- YES → strategy/ (cross-cutting technical decision)
- NO → Check behaviors/

**behaviors/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → behaviors/ (what system does)
- NO → Re-examine classification

**Common Mistakes:**
- ❌ "API returns JSON" → NOT workspace (product-specific) → strategy/
- ❌ "Use 4-space indentation" → NOT strategy (not critical) → workspace/ (if it matters)
- ❌ "System authenticates users" → NOT strategy (observable) → behaviors/

**Correct Examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (applies to any project)
- ✅ "API responses must be JSON" → strategy/architecture.spec.md (product-wide decision)
- ✅ "System authenticates users via OAuth" → behaviors/authentication.spec.md (observable outcome)

## Essential Templates

### Workspace Constitution
```markdown
# [Project Name] Development Constitution

**Criticality**: CRITICAL
**Failure Mode**: Development becomes inconsistent

## Specification
[3-5 core development principles for this project]

## Validation
- [Observable behaviors demonstrating adherence]
```

### Behavior Specification
```markdown
# [Feature Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [Impact if missing]

## Specification
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

## Specification
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
  - src/cache/invalidation.py
extracted_date: 2025-10-06
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from implementation, no tests found for invalidation behavior"
---

# Cache Invalidation

**Criticality**: IMPORTANT (estimated)
**Failure Mode**: Stale data served to users (inferred)

## Specification

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

**Use this template when:**
- Extracting specs from code (Phase 4b)
- Confidence is LOW or MEDIUM
- No tests exist for the behavior
- Multiple interpretations possible

**Promote to standard spec when validated:** Remove extraction metadata, add standard frontmatter (derives_from, satisfies).

## Core Principles

### 1. MSL Minimalism
**From specs/workspace/constitution.spec.md:**
- Specs justify their existence (would system fail without this?)
- Specify WHAT, not HOW
- Only CRITICAL or IMPORTANT requirements
- Trust implementers for details

### 2. Dogfooding
**From specs/workspace/constitution.spec.md:**
- LiveSpec uses its own methodology
- Repository has specs/ and prompts/
- No custom tooling required

### 3. Workspace vs Product
**From specs/strategy/architecture.spec.md:**
- specs/workspace/ = HOW you build (process)
- specs/behaviors/ = WHAT system does (product)
- Clear separation prevents confusion

### 4. Phase 4 is Continuous
**From specs/behaviors/five-phases.spec.md:**
- Drift detection prevents staleness
- Extract new behaviors as they emerge
- Update specs alongside code

### 5. Trust Implementers
**From specs/workspace/constitution.spec.md:**
- Don't over-prescribe implementation details
- Define edges, not paths
- Innovation happens in unspecified spaces

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

## Specification Dependencies

LiveSpec specs form a **dependency graph**, not a hierarchy:
- **Vertical**: PURPOSE → requirements (HLR) → design → implementation → code
- **Horizontal**: Workspace (process) applies across all levels

### Dependency Structure

```
PURPOSE.md (Why - Vision)
  ↓ defines
specs/requirements.spec.md (What - High-Level Requirements)
  ↓ constrains
specs/constraints.spec.md → specs/strategy/architecture.spec.md
  ↓ boundaries                      ↓ approach shapes
                                 specs/prompts/*.spec.md
                                   ↓ implements
                                 prompts/*.md

specs/strategy/architecture.spec.md
  ↓ defines approach
specs/behaviors/*.spec.md (What - Detailed)
  ↓ requires
code (Implementation)
```

**Orthogonal (applies everywhere):**
- `specs/workspace/` - Process governing all development

### Frontmatter Convention

Specs declare dependencies via YAML frontmatter:

```yaml
---
derives_from:
  - PURPOSE.md
  - specs/problem.spec.md
constrained_by:
  - specs/constraints.spec.md
satisfies:
  - specs/problem.spec.md
---
```

**Fields:**
- `derives_from` - Parent specs this is based on
- `constrained_by` - Boundaries this must respect
- `satisfies` - Requirements this fulfills
- `supports` - What this spec enables
- `applies_to` - Scope (for workspace specs)

### Impact Detection

When specs change, trace dependencies:

**Upward (validate):** Does change still align with parents?
```bash
# Check frontmatter
grep "derives_from\|constrained_by" specs/changed-spec.spec.md
```

**Downward (propagate):** What derives from this?
```bash
# Find children
grep -r "derives_from.*changed-spec" specs/
```

**Common impacts:**
| Changed | Check Upward | Check Downward |
|---------|--------------|----------------|
| PURPOSE.md | None (root) | requirements.spec.md, constraints.spec.md |
| requirements.spec.md | PURPOSE.md | architecture.spec.md, behaviors/ |
| architecture.spec.md | requirements.spec.md, constraints.spec.md | prompts/, behaviors/ |
| behaviors/*.spec.md | architecture.spec.md | Code |

See `specs/DEPENDENCIES.md` for complete traceability reference.

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
spec: specs/prompts/0a-setup-workspace.spec.md
---
```

**In specs:**
```markdown
---
specifies: prompts/0-define/0a-setup-workspace.md
---
```

This enables AI agents to navigate between prompts and their specifications.

## When to Fetch Full Prompts

Cache this document, but fetch full prompts when you need:

| Need | Fetch | When |
|------|-------|------|
| Setup workspace | `.livespec/0-define/0a-setup-workspace.md` | New project |
| Define problem | `.livespec/0-define/0b-define-problem.spec.md` | Problem unclear |
| Identify constraints | `.livespec/0-define/0c-identify-constraints.md` | Need boundaries |
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

## Workspace Specs Guide AI

The three workspace specs define HOW this specific project is built:

- **constitution.spec.md** - Development principles and governance
- **patterns.spec.md** - Code and specification patterns
- **workflows.spec.md** - Development process workflows

**Always read workspace specs first** when working on a project. They contain project-specific conventions and constraints.

## Quick Examples by Use Case

### Starting Fresh
```bash
# Copy methodology
cp -r livespec/prompts .livespec

# Create structure
mkdir -p specs/{workspace,behaviors,contracts}

# Use first prompt
# "Use .livespec/0-define/0a-setup-workspace.md"
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

## Development Patterns

**From specs/workspace/patterns.spec.md:**

- All specs use MSL format (.spec.md extension: title, frontmatter, Requirements section)
- British English for user docs (synchronisation, behaviour)
- Phase-letter naming for prompts (0a-, 1b-, 2c-)
- One spec per behavior
- Workspace/product separation in folder structure

## Development Workflows

**From specs/workspace/workflows.spec.md:**

- New prompts require behavior specs first
- Spec changes follow EVOLVE phase workflow
- Changes validated through real usage before merge
- Periodic MSL audits maintain minimalism
- Documentation updates accompany prompt/spec changes

## Final Notes

LiveSpec is just folders and markdown. The methodology guides AI agents to:

1. **Create proper specifications** (Phase 0-1)
2. **Implement from specs** (Phase 2)
3. **Validate correctness** (Phase 3)
4. **Keep specs synchronized** (Phase 4)

Remember: **Start simple, add complexity only when needed. Trust the phases.**

---
*Agent configuration for [LiveSpec v2.0.0](https://github.com/chrs-myrs/livespec) - Generated 2025-10-05*
