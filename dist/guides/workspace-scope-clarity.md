# Workspace Scope Clarity Guide

**Purpose**: Clear guidance on workspace/ vs deliverable boundary to prevent the most common LiveSpec mistake: putting deliverable content in workspace/.

## The Core Principle

**Workspace = Operating Context**

```
"About vs In" Test: "Is this ABOUT the workspace or IN the workspace?"
- ABOUT (operating context) → workspace/
- IN (deliverable) → specs/1-requirements/, 2-strategy/, or 3-behaviors/
```

## The Confusion

**Common mistake**: "Workspace = how WE work" interpreted as "how we work ON THIS PRODUCT"

**Correct understanding**: "Workspace = how agents, humans, and the workspace interact" (operating context)

### Example of Confusion

**❌ Wrong thinking**:
```
"Our workspace should document OUR taxonomy for classifying OUR projects"
→ Creates specs/workspace/taxonomy.spec.md with TMP project dimensions
→ VIOLATION: TMP taxonomy is a product deliverable, not operating context
```

**✅ Right thinking**:
```
"Workspace documents HOW WE OPERATE in this workspace"
→ Creates specs/workspace/taxonomy.spec.md classifying THIS project
→ CORRECT: Uses taxonomy metaspec to classify project (Software/Documentation/Governance/etc.)
```

## The Two Taxonomies Confusion

This is the exact issue from project-governance that prompted this guide:

**Product Taxonomy** (NOT workspace):
```markdown
# ❌ specs/workspace/taxonomy.spec.md (WRONG LOCATION)

## TMP Project Classification System
- Nature: library, application
- Type: code, agentic, hybrid
- Deployment: deployed, internal
- Runtime: lambda, container, server
- Language: typescript, javascript, php, python
```

**"About vs in" test FAILS**: "Is this ABOUT the workspace?" → NO (it's a product feature)
**Correct location**: `specs/2-strategy/project-classification.spec.md`
**Why**: This is a PRODUCT FEATURE (how to classify TMP projects), not operating context

**Project Taxonomy** (YES workspace):
```markdown
# ✅ specs/workspace/taxonomy.spec.md (CORRECT LOCATION)

## Project Domain
Governance - Produces methodology frameworks

## Workspace Scope
**What IS workspace (operating context):**
- constitution.spec.md - Development principles
- patterns.spec.md - Naming conventions
- workflows.spec.md - Development process

**What is NOT workspace (deliverables):**
- TMP taxonomy dimensions → specs/2-strategy/
- Policy validation system → specs/3-behaviors/
```

**"About vs in" test PASSES**: "Is this ABOUT the workspace?" → YES
**Why**: This CLASSIFIES the project (operating context)

## Decision Framework

### Step 1: Identify Content Type

What are you documenting?

| Content | Category |
|---------|----------|
| Spec-first principle | Operating context |
| MSL format requirement | Operating context |
| Phase 0-4 workflow | Operating context |
| TDD approach | Operating context |
| **TMP taxonomy dimensions** | **Deliverable** |
| **Lambda function patterns** | **Deliverable** |
| **Authentication requirements** | **Deliverable** |

### Step 2: Apply "About vs In" Test

Ask: "Is this ABOUT the workspace or IN the workspace?"

**Examples:**

```markdown
# Spec: "All development follows spec-first principle"
Q: Is this ABOUT the workspace?
A: YES (describes how we operate) → workspace/constitution.spec.md
```

```markdown
# Spec: "All Lambda functions use handler pattern"
Q: Is this ABOUT the workspace?
A: NO (describes product architecture) → specs/2-strategy/lambda-architecture.spec.md
```

```markdown
# Spec: "Projects classified by Nature/Type/Deployment"
Q: Is this ABOUT the workspace?
A: NO (describes a product feature) → specs/2-strategy/project-classification.spec.md
```

### Step 3: Check Against Taxonomy Declaration

Your `specs/workspace/taxonomy.spec.md` should explicitly list what IS and is NOT workspace.

**Verify:**
1. Is content listed in "What IS workspace" section?
2. Does it match examples in "What is NOT workspace"?
3. Does it pass "about vs in" test?

## Common Violations and Fixes

### Violation 1: Product Taxonomy in Workspace

**Problem:**
```markdown
# specs/workspace/taxonomy.spec.md
Define TMP's project classification dimensions...
```

**Why wrong**: TMP taxonomy is a product feature (governance system), not operating context

**Fix**:
- Move to `specs/2-strategy/project-classification.spec.md`
- Use `specs/workspace/taxonomy.spec.md` to classify THIS PROJECT per LiveSpec framework

### Violation 2: Architecture Constraints in Workspace

**Problem:**
```markdown
# specs/workspace/patterns.spec.md
## Requirements
- [!] All Lambda functions follow standard handler pattern
```

**Why wrong**: Lambda-specific (architecture choice for this product)

**Fix**:
- Move to `specs/2-strategy/lambda-architecture.spec.md`
- Keep only operating conventions in workspace/patterns.spec.md

### Violation 3: Feature Requirements in Workspace

**Problem:**
```markdown
# specs/workspace/features.spec.md
## Requirements
- [!] System must authenticate users via OAuth
```

**Why wrong**: User authentication is a product feature, not operating context

**Fix**:
- Move to `specs/3-behaviors/authentication.spec.md`
- Workspace doesn't contain product features

## What BELONGS in Workspace

### Constitution (Development Principles)

**Operating context:**
- Spec-first principle
- MSL minimalism
- TDD approach
- Dogfooding commitment
- Git workflow standards

**Test**: "Is this ABOUT how we operate?" → YES

### Patterns (Naming Conventions)

**Operating context:**
- Spec file naming (*.spec.md)
- Phase-letter naming (0a-, 1b-)
- Frontmatter format
- MSL structure requirements

**Test**: "Is this ABOUT how we operate?" → YES

### Workflows (Development Process)

**Operating context:**
- Phase 0-4 sequence
- When to extract specs
- When to detect drift
- How specs evolve with code

**Test**: "Is this ABOUT how we operate?" → YES

### Taxonomy (Project Classification)

**Operating context:**
- Classify THIS project (Software/Documentation/Governance/etc.)
- List what IS workspace (constitution, patterns, workflows, taxonomy)
- List what is NOT workspace (product strategy, product behaviors)
- Specs boundary declaration

**Test**: "Is this ABOUT how we operate?" → YES

## What Does NOT BELONG in Workspace

### Product Strategy (2-strategy/)

- Architecture decisions (Lambda vs container)
- Technology choices (React, TypeScript)
- API design approaches
- Product-specific classification systems

### Product Requirements (1-requirements/)

- Strategic outcomes for THIS product
- Functional requirements
- Constraints specific to THIS domain

### Product Behaviors (3-behaviors/)

- User-facing features
- System behaviors
- Domain-specific processes

## Red Flags (Deliverable Indicators)

If you see these in workspace/, move them:

- Organization names (TMP, Acme Corp)
- Product names or features
- Domain terminology (lending, fintech, e-commerce)
- Technology stacks as requirements
- User-facing features
- Product-specific taxonomies or classification systems

## Validation Commands

**Audit workspace scope:**
```bash
bash scripts/audit-workspace-scope.sh
```

**Checks:**
- Each workspace/ file against "about vs in" test
- Deliverable indicators
- Cross-reference with taxonomy.spec.md declarations

## Historical Context

This guide addresses the exact failure mode discovered in project-governance:

**Issue**: `specs/workspace/taxonomy.spec.md` contained TMP product taxonomy (Nature, Type, Deployment, Runtime, Language dimensions)

**Problem**:
- This is a PRODUCT FEATURE (governance classification system)
- Failed "about vs in" test ("Is this ABOUT the workspace?" → NO)
- Violated workspace principle (not operating context)

**Should have been**:
- Product taxonomy → `specs/2-strategy/project-classification.spec.md`
- Workspace taxonomy → Classify the governance PROJECT itself using LiveSpec framework

**User quote**: "taxonomy doesn't have the content it was designed to hold (what is workspace or not)"

**Root cause**: Confusion between:
- **Product taxonomy** (TMP's classification system for TMP projects)
- **Project taxonomy** (Classifying THIS project using LiveSpec framework)

The "about vs in" test prevents this.

## Workspace Specs Drive Agent Context

**Key insight from two-branch model**: Workspace specs generate the context tree (AGENTS.md, ctxt/).

```
SHARED FOUNDATION (purpose, requirements, strategy)
            ↓ derives into two branches
    ┌───────────────┴───────────────┐
    ↓                               ↓
PRODUCT SPECS                   WORKSPACE SPECS
(3-behaviors/, 3-contracts/)    (workspace/)
    ↓ generates                     ↓ generates
CODE + TESTS                    CONTEXT TREE
                                (AGENTS.md, ctxt/)
                                    ↓ guides
                                AI AGENT BEHAVIOR
```

**Workspace specs = source of truth for AI guidance**:
- constitution.spec.md → Core principles in AGENTS.md
- patterns.spec.md → Format and naming guidance
- workflows.spec.md → Phase workflow in AGENTS.md
- taxonomy.spec.md → Domain classification for context loading

**Regeneration relationship**:
- Change workspace specs → Regenerate AGENTS.md
- AGENTS.md content comes FROM workspace specs
- Don't edit AGENTS.md directly → Update source specs

**This is why workspace scope matters**:
- Deliverables in workspace/ pollute agent context
- Operating context in numbered specs/ gets lost
- Wrong placement = wrong AI guidance

## Quick Reference

**The Simple Rule**: If this is describing WHAT you're building rather than HOW you operate, it doesn't belong in workspace/.

**The workspace/ files** (typically just 4-5):
1. `constitution.spec.md` - Development principles
2. `patterns.spec.md` - Naming conventions
3. `workflows.spec.md` - Development process
4. `taxonomy.spec.md` - Project classification (per LiveSpec framework)
5. `context-architecture.spec.md` - What goes in agent context (optional)

Everything else is a deliverable and belongs in numbered specs/ directories.
