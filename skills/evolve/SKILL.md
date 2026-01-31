---
name: evolve
description: Spec health, learning capture, context generation, and continuous evolution.
argument-hint: [health|learn|context|extract]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# LiveSpec Evolution

Manage specification health, capture learnings, and maintain context. Consolidates evolution and context-generation into unified maintenance workflow.

## Usage

- `/livespec:evolve` - Full evolution workflow (health + context if stale)
- `/livespec:evolve health` - Proactive spec health check
- `/livespec:evolve learn` - Capture session learnings to specs (Correction-as-Spec)
- `/livespec:evolve context` - Regenerate AGENTS.md and context tree
- `/livespec:evolve extract` - Extract specs from unspecified code

**Aliases** (invoke these directly):
- `/livespec:health-report` - Comprehensive health dashboard
- `/livespec:rebuild-context` - Same as `evolve context`
- `/livespec:learn` - Same as `evolve learn`

## Full Evolution Workflow (Default)

When invoked without arguments:

### Step 1: Check Spec Health

Scan for issues:

**Structural Issues:**
- Specs missing frontmatter (criticality, failure_mode)
- Missing validation criteria
- Broken cross-references

**Alignment Issues:**
- Code without specs (unspecified implementations)
- Specs without code (obsolete specs)
- Behaviors changed without spec updates

**Context Issues:**
- AGENTS.md older than workspace specs
- Context tree stale

### Step 2: Report Findings

```
Evolution Status:

Health Issues: [X found]
- [Issue 1]: [Description] → [Fix]
- [Issue 2]: [Description] → [Fix]

Context State:
- AGENTS.md: [current/stale]
- Last generated: [timestamp]

Recommended:
- Run /livespec:evolve health for detailed report
- Run /livespec:evolve context to update AGENTS.md
```

### Step 3: Offer Actions

Use AskUserQuestion:
```
What would you like to address?
- Fix health issues (guided remediation)
- Regenerate context (AGENTS.md)
- Extract missing specs (from code)
- Skip for now
```

---

## Mode: health

**Purpose:** Proactive spec health surfacing with actionable recommendations.

**Invocation:** `/livespec:evolve health`

### Health Checks

**1. Structural Validation (Spec Format)**

```bash
# Check all specs have required sections
for spec in specs/**/*.spec.md; do
  # Verify frontmatter
  grep -q "criticality:" "$spec" || echo "Missing criticality: $spec"
  grep -q "failure_mode:" "$spec" || echo "Missing failure_mode: $spec"

  # Verify Requirements section
  grep -q "## Requirements" "$spec" || echo "Missing Requirements: $spec"

  # Verify Validation section
  grep -q "## Validation" "$spec" || echo "Missing Validation: $spec"
done
```

**2. Cross-Reference Validation**

```bash
# Check all referenced files exist
grep -r "satisfies:\|guided-by:\|derives-from:" specs/ | while read ref; do
  # Extract path and verify exists
done
```

**3. MSL Compliance Check**

For each spec, check:
- Line count reasonable (<100 lines preferred, <200 max)
- No implementation details (patterns like "use X library")
- Requirements are testable (not vague)

**4. Coverage Check**

```bash
# Find code without specs
find src/ lib/ -name "*.ts" -o -name "*.py" | while read code; do
  spec="specs/features/$(basename "$code" .ts).spec.md"
  test -f "$spec" || echo "Unspecified: $code"
done
```

### Health Report Format

```markdown
# Spec Health Report

**Date:** YYYY-MM-DD
**Project:** [name]
**Overall Health:** [GREEN/YELLOW/RED] XX%

## Structural Health (X/Y passing)
- [PASS] All specs have frontmatter
- [FAIL] 3 specs missing Validation section
- [WARN] 2 specs over 200 lines

## Cross-Reference Health (X/Y valid)
- [PASS] All satisfies: references valid
- [FAIL] 1 broken guided-by: reference

## MSL Compliance (X/Y minimal)
- [PASS] Most specs under 100 lines
- [WARN] 2 specs may have implementation details

## Coverage (X/Y specified)
- [WARN] 5 code files without specs

## Remediation

1. Fix missing Validation sections in:
   - specs/features/X.spec.md
   - specs/features/Y.spec.md

2. Update broken reference:
   - specs/features/Z.spec.md → guided-by: path/old.spec.md

3. Consider extracting specs for:
   - src/auth/oauth.ts
   - src/api/payments.ts
```

---

## Mode: learn (Correction-as-Spec)

**Purpose:** Transform session corrections and insights into spec updates.

**Invocation:** `/livespec:evolve learn` or `/livespec:learn`

### Learning Capture Flow

**Step 1: Scan Conversation for Insights**

Look for patterns:

- **Corrections:** "I initially thought X, but actually Y"
- **Clarifications:** "No, I meant..." or "To be clear..."
- **New conventions:** "We should always do X"
- **Discovered constraints:** "This won't work because..."

**Step 2: Categorize Learnings**

| Learning Type | Target Spec |
|---------------|-------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |
| Constraint | specs/foundation/constraints.spec.md |

**Step 3: Present for Confirmation**

Use AskUserQuestion:
```
Session Insights Found:

Which should update specs?
[MultiSelect: true]

- "Always check taxonomy before creating files"
  → Update specs/workspace/patterns.spec.md

- "API uses JWT tokens, not sessions"
  → Update specs/strategy/auth.spec.md

- "Add custom learning" (describe something not listed)
```

**Step 4: Apply MSL Gate**

Before adding to spec, verify:
1. Is this essential? (would specs fail without it?)
2. Is this WHAT not HOW? (not implementation detail)
3. What problem does this prevent? (real, not theoretical)

If fails MSL gate: Don't add to spec. Explain why.

**Step 5: Update Specs**

For each confirmed learning:
1. Read target spec
2. Add requirement with [!] marker
3. Preserve MSL format
4. Add to appropriate section

**Step 6: Rebuild Context**

After updates:
```bash
# Regenerate AGENTS.md to include learnings
/livespec:rebuild-context
```

Report:
```
Applied [X] learnings to specs:
- specs/workspace/patterns.spec.md (added: "Check taxonomy first")
- specs/strategy/auth.spec.md (clarified: JWT authentication)

Context rebuilt. Learnings now in AGENTS.md.
```

---

## Mode: context

**Purpose:** Regenerate AGENTS.md and context tree from workspace specifications.

**Invocation:** `/livespec:evolve context` or `/livespec:rebuild-context`

### Context Generation Workflow

**Step 1: Gather Sources**

Read workspace specifications:
- PURPOSE.md
- specs/workspace/constitution.spec.md
- specs/workspace/patterns.spec.md
- specs/workspace/workflows.spec.md
- specs/workspace/taxonomy.spec.md

**Step 2: Check Configuration**

Read `project.yaml` for:
- `context_compression`: light | moderate | aggressive
- `doc_format`: AGENTS.md | CLAUDE.md
- `context_budget`: target size in KB

Defaults: moderate compression, AGENTS.md format, 40KB budget

**Step 3: Structure Content**

Apply START/MIDDLE/END positioning:

**START (30-40%)** - Critical rules, read first:
- Spec-first enforcement
- Core principles
- Critical constraints

**MIDDLE (40%)** - Details and examples:
- Phase workflows
- MSL format reference
- Decision trees
- Folder organization

**END (20-30%)** - References:
- Prompt registry
- When to fetch full context
- Current priorities

**Step 4: Apply Compression**

Based on compression level:

| Level | Inline | References | Target |
|-------|--------|------------|--------|
| Light | Full examples | Minimal | 80-100KB |
| Moderate | Key examples | Strategic | 50-70KB |
| Aggressive | Minimal | Heavy | 30-50KB |

**Step 5: Generate File**

```markdown
---
generated: [ISO timestamp]
generator: livespec/evolve
version: 5.0.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, use /livespec:rebuild-context
---

> **Generated File**: Do not edit directly. Use /livespec:rebuild-context.

# [Project Name] Agent Configuration

## Summary
[From PURPOSE.md]

---

[START SECTION - Critical Rules]

[MIDDLE SECTION - Details]

[END SECTION - References]

---

*Agent configuration for [Project] v[version]*
```

**Step 6: Validate**

```bash
# Size check
wc -c AGENTS.md

# Structure check
grep "^## " AGENTS.md

# Verify under budget
```

Report:
```
Context regenerated:
- AGENTS.md: [size]KB ([compression] compression)
- Sections: [count]
- Last source update: [timestamp]
```

---

## Mode: extract

**Purpose:** Extract specifications from existing code (brownfield projects).

**Invocation:** `/livespec:evolve extract`

### Extraction Workflow

**Step 1: Identify Unspecified Code**

```bash
# Find code without specs
for f in src/**/*.ts lib/**/*.py; do
  if ! grep -q "Implements:" "$f"; then
    echo "UNSPECIFIED: $f"
  fi
done
```

**Step 2: Analyze Code Behavior**

For each unspecified file:
- What observable behavior does it provide?
- What are the inputs/outputs?
- What error conditions are handled?
- What constraints are enforced?

**Step 3: Draft Behavior Spec**

Create spec with confidence markers:

```yaml
---
criticality: IMPORTANT
failure_mode: Inferred - requires validation
extracted_from:
  - src/auth/oauth.py
extracted_date: 2025-01-31
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from code, needs review"
---
```

**Step 4: Present for Review**

```
Extracted Specs (REVIEW REQUIRED):

specs/features/oauth-flow.spec.md (60% confidence)
- Extracted from: src/auth/oauth.py
- Review: Verify auth flow matches intent
- Requirements: 3 inferred

specs/features/retry-logic.spec.md (75% confidence)
- Extracted from: src/utils/retry.ts
- Review: Confirm retry parameters
- Requirements: 2 inferred
```

**Step 5: Validate Extractions**

Use AskUserQuestion to review each:
- Is this behavior correct?
- Any missing requirements?
- Should this be merged with existing spec?

**Step 6: Promote Validated Specs**

Remove confidence markers after review:
- `confidence: LOW` → remove
- `requires_validation: true` → remove
- Add proper `satisfies:` and `guided-by:` relationships

---

## References

For detailed workflows:
- Health checks: `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/run-health-report.md`
- Learning capture: `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/learn.md`
- Context generation: `${CLAUDE_PLUGIN_ROOT}/references/standards/conventions/context-tree.spec.md`
- Spec extraction: `${CLAUDE_PLUGIN_ROOT}/references/prompts/evolve/4b-extract-specs.md`

## Validation

After evolution:
- All specs pass health checks
- AGENTS.md reflects current workspace specs
- No orphaned or obsolete specs
- Run `/livespec:validate` to confirm
