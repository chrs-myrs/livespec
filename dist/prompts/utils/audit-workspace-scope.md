---
implements: specs/3-artifacts/prompts/utils-audit-workspace-scope.spec.md
implements: specs/3-behaviors/validation/workspace-scope-audit.spec.md
derives-from:
  - specs/workspace/taxonomy.spec.md
  - specs/workspace/patterns.spec.md
---

# Audit Workspace Scope

**Purpose**: Detect product-specific content in workspace/ that violates portability principle ("Could I use this in ANY project?").

**When to use:**
- After Phase 0 (DEFINE) workspace setup
- Before releases (verify clean boundary)
- Monthly maintenance (prevent scope creep)
- After adding files to workspace/
- User reports workspace/product confusion

**What it audits:**
1. **Portability test**: Each workspace/ file against "works in ANY project?" criterion
2. **Product indicators**: Feature names, domain terminology, architecture constraints
3. **Taxonomy compliance**: Cross-reference with taxonomy.spec.md Workspace Scope section

---

## Audit Process

### Step 1: Run Automated Audit

```bash
bash scripts/audit-workspace-scope.sh
```

The script checks for product-specific indicators:
- Organization names (TMP, Acme Corp)
- Feature requirements (authentication, payment)
- Architecture constraints (Lambda, React)
- Domain terminology (lending, fintech)

### Step 2: Review Flagged Files

For each violation:
1. Read flagged file section
2. Apply portability test: "Could React library use this?"
3. Determine if content is methodology (portable) or product (specific)

### Step 3: Relocate Product-Specific Content

**Decision matrix:**

| Content Type | Current Location | Correct Location |
|--------------|------------------|------------------|
| Feature requirements | workspace/ | specs/1-requirements/functional/ |
| Product behaviors | workspace/ | specs/3-behaviors/ |
| Architecture decisions | workspace/ | specs/2-strategy/ |
| Product taxonomy | workspace/taxonomy.spec.md | specs/2-strategy/classification.spec.md |

### Step 4: Update Taxonomy Declaration

Verify `specs/workspace/taxonomy.spec.md` Workspace Scope section accurately lists what IS and is NOT workspace.

---

## Common Violations

### ❌ Product Taxonomy in Workspace

```markdown
# specs/workspace/taxonomy.spec.md
## TMP Project Classification
- Nature: library, application
- Type: code, agentic, hybrid
```

**Problem**: TMP-specific classification system (product feature)
**Fix**: Move to `specs/2-strategy/project-classification.spec.md`
**Test**: "Can React library use TMP taxonomy?" → NO → Not workspace

### ❌ Architecture Constraints in Workspace

```markdown
# specs/workspace/patterns.spec.md
## Requirements
- [!] All Lambda functions use handler pattern
```

**Problem**: Lambda-specific (architecture constraint)
**Fix**: Move to `specs/2-strategy/lambda-architecture.spec.md`
**Test**: "Does container project need Lambda patterns?" → NO → Not workspace

### ✅ Valid Workspace Content

```markdown
# specs/workspace/constitution.spec.md
## Requirements
- [!] All development follows spec-first principle
```

**Reason**: Spec-first applies to ANY project (portable methodology)
**Test**: "Can ANY project use spec-first?" → YES → Valid workspace

---

## Expected Outcomes

- All workspace/ files pass portability test
- Product-specific content relocated appropriately
- taxonomy.spec.md Workspace Scope section accurate
- Clear workspace/product boundary for agents
- Methodology reusable in other projects

---

## Historical Context

This audit prevents the exact issue found in project-governance where:
- `taxonomy.spec.md` contained TMP product taxonomy (Nature, Type, Deployment dimensions)
- Failed portability test ("Works in React library?" → NO)
- Should have been in `specs/2-strategy/project-classification.spec.md`
- User reported: "taxonomy doesn't have the content it was designed to hold"
