# AUDIT Mode

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

Sub-agent context for spec health, frontmatter compliance, learning capture, and context validation.

## Summary

Audit mode maintains specification health through continuous monitoring. Detects when specs and reality diverge, validates frontmatter compliance (IMP-005), extracts learnings from sessions, and keeps context current.

## When to Use

**Entry conditions:**
- System in production OR active development
- Specs and code exist (can drift)
- Session complete with learnings to capture
- Frontmatter compliance needs checking

**Frequency:**
- Health checks: Weekly (minimum) or before releases
- Frontmatter validation: Before every commit
- Learning capture: End of each session
- Context rebuild: When workspace specs change

## Frontmatter Compliance (IMP-005)

### Run Validation

```bash
scripts/validate-frontmatter.sh
```

**Checks:**
- All six base fields present (type, category, fidelity, criticality, failure_mode, governed-by)
- `type` value is from allowed set
- `category` matches directory location
- `fidelity` is from allowed values
- Per-category mandatory fields present
- `governed-by` does NOT contain metaspec paths
- No underscore field names (rejects `derives_from`, `guided_by`)

**Exit code 0:** All checks pass
**Exit code 1:** Failures found — must fix before committing

### Common Failures

**Missing base fields:**
```
ERROR: specs/features/auth.spec.md missing 'type' field
Fix: Add type: behavior to frontmatter
```

**Wrong type value:**
```
ERROR: specs/features/auth.spec.md has type: 'feature' (invalid)
Fix: Change to type: behavior
```

**Metaspec in governed-by:**
```
WARNING: specs/features/auth.spec.md governed-by contains metaspec path
  .livespec/standard/metaspecs/behavior.spec.md
Fix: Remove — format governance is implied by type field
```

**Underscore field name:**
```
ERROR: specs/features/auth.spec.md uses derives_from (underscore)
Fix: Rename to derives-from
```

**Missing per-category field:**
```
ERROR: specs/features/auth.spec.md (category: features) missing 'satisfies'
Fix: Add satisfies: [specs/foundation/outcomes.spec.md ...]
```

### Per-Category Reminder

| Category | Required fields beyond base six |
|----------|----------------------------------|
| workspace | `applies_to` |
| foundation | `derives-from`, `supports` |
| strategy | `derives-from` |
| features | `satisfies`, `guided-by` |
| interfaces | `supports` |
| artifacts | `specifies` |

## Health Detection

### Spec-Code Drift

**Implementations without specs:**
```
Found: src/api/new-endpoint.py
Missing: specs/features/new-endpoint.spec.md

Action: /livespec:audit extract
```

**Specs without implementations:**
```
Found: specs/features/obsolete-feature.spec.md
Missing: Implementation (deleted but spec remains)

Action: git rm specs/features/obsolete-feature.spec.md
```

**Behaviors changed without spec updates:**
```
Found: src/auth/oauth.py (flow changed)
Outdated: specs/features/authentication.spec.md

Action: /livespec:design refine specs/features/authentication.spec.md
```

### Structural Drift

**Broken cross-references:**
```
specs/features/auth.spec.md
  → guided-by: specs/strategy/old-arch.spec.md (missing!)

Action: Update frontmatter with correct path
```

**Generated files edited directly:**
```
AGENTS.md modified by hand

Action: Revert, run /livespec:audit context
```

### Context Drift

**AGENTS.md stale:**
```bash
for spec in specs/workspace/*.spec.md; do
  if [ "$spec" -nt "AGENTS.md" ]; then
    echo "STALE: AGENTS.md older than $spec"
  fi
done
```

**Action:** `/livespec:audit context`

## Learning Capture (Correction-as-Spec)

### Session Insight Patterns

**Corrections made:**
- "I initially thought X, but actually it's Y"
- Mistaken assumptions corrected
- Wrong approaches abandoned

**User clarifications:**
- "No, I meant..."
- Requirements refined during discussion
- Scope adjusted based on feedback

**Patterns emerged:**
- Same problem hit multiple times
- New conventions established
- "We should always do X" statements

### Learning → Spec Flow

```
Session insight detected
         ↓
Categorize (workspace/strategy/features)
         ↓
Present options to user (AskUserQuestion)
         ↓
Apply MSL gate (essential? not HOW? proven problem?)
         ↓
Update target spec (with correct frontmatter)
         ↓
Rebuild context
```

### Learning Routing

| Learning Type | Target Location |
|---------------|-----------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |
| Hard Constraint | specs/foundation/constraints.spec.md |

## Health Report Format

```markdown
# Spec Health Report

**Date:** YYYY-MM-DD
**Overall Health:** [GREEN/YELLOW/RED] XX%

## Frontmatter Compliance (IMP-005)
- [PASS] All specs have six base fields
- [FAIL] 2 specs missing per-category fields
- [WARN] 1 spec has governed-by metaspec reference

## Structural Health (X/Y passing)
- [PASS] All specs have frontmatter
- [FAIL] 3 specs missing Validation section

## Cross-Reference Health (X/Y valid)
- [PASS] All satisfies: references valid
- [FAIL] 1 broken guided-by: reference

## MSL Compliance (X/Y minimal)
- [PASS] Most specs under 100 lines
- [WARN] 2 specs may have implementation details

## Remediation

1. Fix missing per-category fields (run scripts/validate-frontmatter.sh for detail)
2. Remove metaspec from governed-by (format implied by type field)
3. Fix missing Validation sections
4. Update broken reference
```

## Remediation Strategies

### Code without specs

```bash
/livespec:audit extract
# Creates spec with confidence markers
# Apply correct frontmatter (type, category, fidelity + per-category fields)
# Validate and promote
```

### Spec without code

```bash
# Verify truly obsolete
git log --all --full-history -- specs/features/obsolete.spec.md

# Delete if confirmed
git rm specs/features/obsolete.spec.md
```

### Behavior changed without spec update

```bash
# Option A: Spec was correct, code wrong
# Revert code to match spec

# Option B: Code is correct, spec outdated
/livespec:design refine specs/features/<spec>.spec.md
```

### Stale context

```bash
/livespec:audit context
# Regenerates AGENTS.md from workspace specs
```

## Continuous Evolution Pattern

### Weekly Maintenance

```bash
# Monday: Check frontmatter + health
scripts/validate-frontmatter.sh
/livespec:audit health

# Triage:
# - ERROR: Fix immediately (frontmatter)
# - CRITICAL: Fix immediately (health)
# - IMPORTANT: Fix this week
# - MINOR: Backlog

# Friday: Confirm sync
/livespec:audit validate
```

### Pre-Release Validation

```bash
# All validations must pass for release
scripts/validate-frontmatter.sh
prompts/utils/validate-project.md

# Rebuild context
/livespec:audit context
```

### Session End

```bash
# Capture learnings
/livespec:learn

# Result: Fresh session with captured knowledge
```

## References

- Audit skill: `/livespec:audit`
- Learn skill: `/livespec:learn`
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Frontmatter spec: `specs/features/mandatory-frontmatter.spec.md`
- Frontmatter script: `scripts/validate-frontmatter.sh`
- Parent context: AGENTS.md

---

*Audit mode specialist for LiveSpec v5.3.0*
*Parent: AGENTS.md*
