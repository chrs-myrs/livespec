# Workspace Scope Clarity Guide

**Purpose**: Clear guidance on workspace/ vs product boundary to prevent the most common LiveSpec mistake: putting product-specific content in workspace/.

## The Core Principle

**Workspace = Portable Methodology**

```
Portability Test: "Could I use this EXACT spec in ANY project?"
- YES → workspace/ (portable methodology)
- NO → specs/1-requirements/, 2-strategy/, or 3-behaviors/ (product-specific)
```

## The Confusion

**Common mistake**: "Workspace = how WE work" interpreted as "how we work ON THIS PRODUCT"

**Correct understanding**: "Workspace = how ANYONE works using LiveSpec methodology"

### Example of Confusion

**❌ Wrong thinking**:
```
"Our workspace should document OUR taxonomy for classifying OUR projects"
→ Creates specs/workspace/taxonomy.spec.md with TMP project dimensions
→ VIOLATION: TMP taxonomy is product-specific, not portable methodology
```

**✅ Right thinking**:
```
"Workspace documents the LIVESPEC methodology WE follow"
→ Creates specs/workspace/taxonomy.spec.md classifying THIS project per LiveSpec framework
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

**Portability test FAILS**: "Can React library use TMP taxonomy?" → NO
**Correct location**: `specs/2-strategy/project-classification.spec.md`
**Why**: This is a PRODUCT FEATURE (how to classify TMP projects), not portable methodology

**Project Taxonomy** (YES workspace):
```markdown
# ✅ specs/workspace/taxonomy.spec.md (CORRECT LOCATION)

## Project Domain
Governance - Produces methodology frameworks

## Workspace Scope
**What IS workspace:**
- constitution.spec.md - Development principles (portable)
- patterns.spec.md - Naming conventions (portable)
- workflows.spec.md - Development process (portable)

**What is NOT workspace:**
- TMP taxonomy dimensions → specs/2-strategy/
- Policy validation system → specs/3-behaviors/
```

**Portability test PASSES**: "Can ANY project use this structure?" → YES
**Why**: This CLASSIFIES the project using LiveSpec framework (portable)

## Decision Framework

### Step 1: Identify Content Type

What are you documenting?

| Content | Category |
|---------|----------|
| Spec-first principle | Methodology |
| MSL format requirement | Methodology |
| Phase 0-4 workflow | Methodology |
| TDD approach | Methodology |
| **TMP taxonomy dimensions** | **Product feature** |
| **Lambda function patterns** | **Architecture constraint** |
| **Authentication requirements** | **Product requirement** |

### Step 2: Apply Portability Test

Ask: "Could I copy this spec to a completely different project and use it?"

**Examples:**

```markdown
# Spec: "All development follows spec-first principle"
Q: Could React library use this?
A: YES → workspace/constitution.spec.md
```

```markdown
# Spec: "All Lambda functions use handler pattern"
Q: Could React library use this?
A: NO (React doesn't have Lambda functions) → specs/2-strategy/lambda-architecture.spec.md
```

```markdown
# Spec: "Projects classified by Nature/Type/Deployment"
Q: Could ANY project use TMP's classification system?
A: NO (TMP-specific product feature) → specs/2-strategy/project-classification.spec.md
```

### Step 3: Check Against Taxonomy Declaration

Your `specs/workspace/taxonomy.spec.md` should explicitly list what IS and is NOT workspace.

**Verify:**
1. Is content listed in "What IS workspace" section?
2. Does it match examples in "What is NOT workspace"?
3. Does it pass portability test?

## Common Violations and Fixes

### Violation 1: Product Taxonomy in Workspace

**Problem:**
```markdown
# specs/workspace/taxonomy.spec.md
Define TMP's project classification dimensions...
```

**Why wrong**: TMP taxonomy is a product feature (governance system), not LiveSpec methodology

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
- Keep only language-agnostic patterns in workspace/patterns.spec.md

### Violation 3: Feature Requirements in Workspace

**Problem:**
```markdown
# specs/workspace/features.spec.md
## Requirements
- [!] System must authenticate users via OAuth
```

**Why wrong**: User authentication is a product feature, not development methodology

**Fix**:
- Move to `specs/3-behaviors/authentication.spec.md`
- Workspace doesn't contain product features

## What BELONGS in Workspace

### Constitution (Development Principles)

**Portable methodology:**
- Spec-first principle
- MSL minimalism
- TDD approach
- Dogfooding commitment
- Git workflow standards

**Test**: "Can ANY project follow these principles?" → YES

### Patterns (Naming Conventions)

**Portable methodology:**
- Spec file naming (*.spec.md)
- Phase-letter naming (0a-, 1b-)
- Frontmatter format
- MSL structure requirements

**Test**: "Can ANY project use these patterns?" → YES

### Workflows (Development Process)

**Portable methodology:**
- Phase 0-4 sequence
- When to extract specs
- When to detect drift
- How specs evolve with code

**Test**: "Can ANY project follow this workflow?" → YES

### Taxonomy (Project Classification)

**Portable methodology:**
- Classify THIS project (Software/Documentation/Governance/etc.)
- List what IS workspace (constitution, patterns, workflows, taxonomy)
- List what is NOT workspace (product strategy, product behaviors)
- Specs boundary declaration

**Test**: "Can ANY project use LiveSpec taxonomy metaspec?" → YES

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

## Red Flags (Portability Failures)

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
- Each workspace/ file against portability test
- Product-specific indicators
- Cross-reference with taxonomy.spec.md declarations

## Historical Context

This guide addresses the exact failure mode discovered in project-governance:

**Issue**: `specs/workspace/taxonomy.spec.md` contained TMP product taxonomy (Nature, Type, Deployment, Runtime, Language dimensions)

**Problem**:
- This is a PRODUCT FEATURE (governance classification system)
- Failed portability test ("Can React library use TMP taxonomy?" → NO)
- Violated workspace principle (not portable methodology)

**Should have been**:
- Product taxonomy → `specs/2-strategy/project-classification.spec.md`
- Workspace taxonomy → Classify the governance PROJECT itself using LiveSpec framework

**User quote**: "taxonomy doesn't have the content it was designed to hold (what is workspace or not)"

**Root cause**: Confusion between:
- **Product taxonomy** (TMP's classification system for TMP projects)
- **Project taxonomy** (Classifying THIS project using LiveSpec framework)

This is the most common LiveSpec mistake. The portability test prevents it.

## Quick Reference

**The Simple Rule**: If you can't copy this spec to a React library, Node.js API, or Python CLI and use it unchanged, it doesn't belong in workspace/.

**The workspace/ files** (typically just 4):
1. `constitution.spec.md` - Development principles
2. `patterns.spec.md` - Naming conventions
3. `workflows.spec.md` - Development process
4. `taxonomy.spec.md` - Project classification (per LiveSpec framework)

Everything else is product-specific and belongs in numbered specs/ directories.
