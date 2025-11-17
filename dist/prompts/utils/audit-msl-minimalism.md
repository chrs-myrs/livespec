---
implements: specs/3-behaviors/slash-command-generation.spec.md
phase: utilities
---

# Audit MSL Minimalism

**Purpose:** Check specifications for over-specification and violations of MSL minimalism principles.

**When to use:** Monthly spec reviews, before releases, when specs feel bloated, or as part of `/livespec/audit minimalism` command.

---

## Instructions for AI Agent

You are auditing specifications for adherence to MSL minimalism principles. Flag over-specification, HOW violations, and non-essential requirements.

### Step 1: Read MSL Minimalism Guide

```bash
cat .livespec/guides/msl-minimalism.md
```

**Extract the 4 essential questions:**
1. Is this essential?
2. Am I specifying HOW instead of WHAT?
3. What specific problem does this prevent?
4. Could this be inferred or conventional?

### Step 2: Select Specs to Audit

**Default scope:** All specs in `specs/` directory

**Focused audit:**
- `specs/3-behaviors/*.spec.md` - Behavior specifications
- `specs/2-strategy/*.spec.md` - Strategy specifications
- `specs/workspace/*.spec.md` - Workspace patterns

**Skip:**
- `.archive/` - Archived specs not in use
- `specs/1-requirements/` - High-level requirements (different rules)

### Step 3: Audit Each Spec

**For each spec, check requirements against 4 questions:**

**Question 1: Is this essential?**
- Look for "nice-to-have" language: "should", "could", "ideally"
- Flag requirements that don't cause failure if missing
- Example violation: "Button should be blue" (cosmetic, not essential)

**Question 2: HOW vs WHAT?**
- Scan for code blocks in spec files
- Look for implementation details: algorithms, data structures, specific libraries
- Flag technology-specific requirements without justification
- Example violation: "Use Redis for caching" (HOW) vs "System caches API responses" (WHAT)

**Question 3: Problem prevention?**
- Check if each requirement cites a specific problem
- Flag theoretical concerns without evidence
- Look for "failure_mode" in frontmatter (good practice)
- Example violation: "Validate all inputs" (vague) vs "Reject SQL injection attempts" (specific problem)

**Question 4: Inferred or conventional?**
- Flag requirements that describe standard practice
- Check if requirement obvious from context
- Look for over-documented conventions
- Example violation: "Use Git for version control" (conventional in modern dev)

### Step 4: Scan for Common Violations

**Code in specs (HOW violation):**
```bash
# Find specs with code blocks
find specs/ -name "*.spec.md" -exec grep -l '```' {} \; | while read spec; do
  # Check if code blocks are examples (OK) or specifications (NOT OK)
  echo "Check: $spec (has code blocks)"
done
```

**Technology lock-in (premature HOW):**
- Search for: specific library names, version numbers, implementation patterns
- Acceptable if justified in `failure_mode` or critical for requirements
- Example: "Use PostgreSQL 15" needs justification why not "Store data relationally"

**Excessive precision (implementation detail):**
- Numbers without ranges: "exactly 100ms" vs "under 100ms"
- Specific algorithms: "use quicksort" vs "sort efficiently"
- UI specifics: "button at (100, 200)" vs "submit button visible"

### Step 5: Calculate Bloat Score

**For each spec:**
- Count total requirements (lines starting with `- [!]` or `- [?]`)
- Count violations (requirements failing questions 1-4)
- Calculate bloat percentage: (violations / total) × 100%

**Scoring:**
- 🟢 Minimal: 0-10% bloat (excellent)
- 🟡 Acceptable: 11-25% bloat (could trim)
- 🔴 Bloated: >25% bloat (needs revision)

### Step 6: Generate Audit Report

**Format (concise):**

```markdown
# MSL Minimalism Audit Report

**Date:** YYYY-MM-DD
**Specs Audited:** [X] files

---

## Summary

| Status | Count | Specs |
|--------|-------|-------|
| 🟢 Minimal (0-10%) | X | [list] |
| 🟡 Acceptable (11-25%) | X | [list] |
| 🔴 Bloated (>25%) | X | [list] |

**Overall Health:** [🟢🟡🔴] - [X]% average bloat

---

## 🔴 Critical Violations (Bloated Specs)

### [spec-name.spec.md] - XX% bloat

**Violations:**
1. **Non-essential requirement** (Q1): "[Requirement text]"
   - Why: [Explanation]
   - Recommendation: Remove or demote to documentation

2. **HOW specification** (Q2): "[Requirement text]"
   - Why: [Implementation detail]
   - Recommendation: Rewrite as WHAT: "[Suggested rewrite]"

3. **No problem cited** (Q3): "[Requirement text]"
   - Why: [Theoretical concern]
   - Recommendation: Remove or cite specific problem

4. **Conventional practice** (Q4): "[Requirement text]"
   - Why: [Standard in domain]
   - Recommendation: Trust implementers, remove from spec

---

## 🟡 Moderate Issues

[Same format, but less critical]

---

## 🟢 Exemplars (Minimal Specs)

- [spec1.spec.md] - 0% bloat, excellent minimalism
- [spec2.spec.md] - 5% bloat, clear WHAT focus

**What they do well:**
- Outcome-focused requirements
- No implementation details
- Specific problem prevention
- Trust implementers

---

## Recommendations

1. **Immediate:** Address all 🔴 bloated specs (>25% violations)
2. **Soon:** Review 🟡 acceptable specs (11-25%)
3. **Ongoing:** Apply 4 questions before adding any requirement
4. **Culture:** Encourage "what's the failure mode?" during reviews

---

## Common Patterns Found

**Most frequent violation:** [Q1/Q2/Q3/Q4]
**Most over-specified area:** [behaviors/strategy/workspace]
**Positive trend:** [What's working well]
```

### Step 7: Provide Actionable Next Steps

**For each 🔴 bloated spec:**
```
To fix [spec-name.spec.md]:
1. Remove non-essential requirements (lines X, Y, Z)
2. Rewrite HOW as WHAT (line A: "[current]" → "[suggested]")
3. Justify or remove (line B: cite specific problem or delete)
4. Trust implementers (line C: remove conventional practice)

Estimated reduction: XX requirements → YY requirements (ZZ% reduction)
```

---

## When NOT to Use This Audit

**Skip if:**
- Specs recently written following MSL guide (trust process)
- Team new to MSL (education first, audit later)
- In crisis mode (fix critical bugs, audit later)
- No time to act on findings (audit creates tech debt)

**Use when:**
- Specs feel bloated or hard to implement
- Before major releases (ensure clean requirements)
- Onboarding new team (show good examples)
- Quarterly health checks

---

## Output Quality Checklist

Before presenting report:
- [ ] All 4 questions applied to each requirement
- [ ] Bloat scores calculated correctly
- [ ] Violations specific with line numbers
- [ ] Recommendations actionable (not vague "improve")
- [ ] Examples of good specs highlighted
- [ ] Next steps clear and prioritized

---

**Remember:** MSL minimalism is about trust. Specs define edges (WHAT), not paths (HOW). Innovation happens in unspecified spaces.
