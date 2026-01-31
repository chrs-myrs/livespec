# EVOLVE Mode

Sub-agent context for spec health, learning capture, and drift detection.

## Summary

Evolve mode maintains specification health through continuous evolution. This mode detects when specs and reality diverge, extracts learnings from sessions, and keeps context current. Consolidates drift detection into unified health management.

## When to Use

**Entry conditions:**
- System in production OR active development
- Specs and code exist (can drift)
- Session complete with learnings to capture

**Frequency:**
- Health checks: Weekly (minimum) or before releases
- Learning capture: End of each session
- Context rebuild: When workspace specs change

## Health Detection

### Spec-Code Drift

**Implementations without specs:**
```
Found: src/api/new-endpoint.py
Missing: specs/features/new-endpoint.spec.md

Action: /livespec:evolve extract
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

Action: /livespec:refine specs/features/authentication.spec.md
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

Action: Revert, run /livespec:rebuild-context
```

### Context Drift

**AGENTS.md stale:**
```bash
# Check if workspace specs newer than AGENTS.md
for spec in specs/workspace/*.spec.md; do
  if [ "$spec" -nt "AGENTS.md" ]; then
    echo "STALE: AGENTS.md older than $spec"
  fi
done
```

**Action:** `/livespec:rebuild-context`

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
Update target spec
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

1. Fix missing Validation sections
2. Update broken reference
3. Consider extracting specs for unspecified code
```

## Remediation Strategies

### Code without specs

```bash
/livespec:evolve extract
# Creates spec with confidence markers
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
/livespec:refine specs/features/<spec>.spec.md
```

### Stale context

```bash
/livespec:rebuild-context
# Regenerates AGENTS.md from workspace specs
```

## Continuous Evolution Pattern

### Weekly Maintenance

```bash
# Monday: Check health
/livespec:evolve health

# Triage:
# - CRITICAL: Fix immediately
# - IMPORTANT: Fix this week
# - MINOR: Backlog

# Friday: Confirm sync
/livespec:validate
```

### Pre-Release Validation

```bash
# Detect drift
/livespec:evolve health

# Must be zero issues for release:
# ✅ All drift resolved → Proceed
# ❌ Drift exists → Fix first

# Rebuild context
/livespec:rebuild-context
```

### Session End

```bash
# Complete session
/livespec:session-review

# Capture learnings
/livespec:learn

# Result: Fresh session with captured knowledge
```

## References

- Evolve skill: `/livespec:evolve`
- Health command: `/livespec:health-report`
- Learn command: `/livespec:learn`
- Parent context: AGENTS.md

---

*Evolve mode specialist for LiveSpec*
*Parent: AGENTS.md*
