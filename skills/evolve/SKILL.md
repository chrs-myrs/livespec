---
name: evolve
description: Spec health, validation, context generation, and continuous evolution
argument-hint: [health|validate|audit|context|extract]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# LiveSpec Evolution

Manage specification health, run validation, regenerate context, and maintain the spec ecosystem.

## Usage

- `/livespec:evolve` - Full evolution workflow (health + context if stale)
- `/livespec:evolve health` - Proactive spec health check
- `/livespec:evolve validate` - Run validation checks
- `/livespec:evolve audit [type]` - Quality audits (msl|scope|coverage)
- `/livespec:evolve context` - Regenerate AGENTS.md and context tree
- `/livespec:evolve extract` - Extract specs from unspecified code

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

## Mode: validate

**Purpose:** Run validation checks and report pass/fail status.

**Invocation:** `/livespec:evolve validate`

### Validation Checks

**1. Cross-Reference Integrity**
- All `satisfies:`, `guided-by:`, `derives-from:` references point to existing files
- No circular dependencies

**2. Generated File Protection**
- AGENTS.md/CLAUDE.md not directly edited (check generated header)
- Regeneration needed if source specs newer

**3. MSL Format Compliance**
- All specs have required frontmatter
- Requirements section present with [!] markers
- Validation criteria defined

**4. Folder Structure**
- specs/ follows taxonomy
- No misplaced files

### Output Format

```
Validation Results:

[PASS] Cross-reference integrity (24/24 valid)
[PASS] Generated file protection (AGENTS.md current)
[FAIL] MSL format compliance (2 specs missing Validation)
[PASS] Folder structure correct

Overall: 3/4 checks passed

Fix required:
- specs/features/auth.spec.md: Add ## Validation section
- specs/features/payment.spec.md: Add ## Validation section
```

---

## Mode: audit [type]

**Purpose:** Deep quality analysis of specific aspects.

**Invocation:** `/livespec:evolve audit [msl|scope|coverage]`

### audit msl

Checks MSL minimalism compliance:
- Requirements are WHAT not HOW
- No implementation details
- Essential requirements only
- Proper criticality levels

### audit scope

Checks workspace scope clarity:
- Taxonomy correctly classifies project
- Specs in correct folders
- No scope creep

### audit coverage

Checks spec coverage:
- Code files with/without specs
- Behaviors specified
- Contracts defined

---

## Mode: context

**Purpose:** Regenerate AGENTS.md and context tree from workspace specifications.

**Invocation:** `/livespec:evolve context`

### Context Generation Workflow

**IMPORTANT:** Delegate this work to the `context-builder` agent. Context generation reads many large source files and produces substantial output — running it inline wastes the session's context window.

**Step 1:** Launch the `context-builder` agent using the Agent tool:
- The agent reads all workspace specs, PURPOSE.md, and project.yaml
- It generates AGENTS.md + all ctxt/ sub-agents
- It validates sizes and structure
- It returns a structured report

**Step 2:** Review the agent's report and relay results to the user:
```
Context regenerated:
- AGENTS.md: [size]KB ([compression] compression)
- Sub-agents: [count] files ([total]KB)
- Total: [total]KB
- Version: v[version]
```

**Step 3:** If the user is satisfied, suggest committing the regenerated files.

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
- Context generation: `${CLAUDE_PLUGIN_ROOT}/references/standards/conventions/context-tree.spec.md`
- Spec extraction: `${CLAUDE_PLUGIN_ROOT}/references/prompts/evolve/4b-extract-specs.md`

## Validation

After evolution:
- All specs pass health checks
- AGENTS.md reflects current workspace specs
- No orphaned or obsolete specs
