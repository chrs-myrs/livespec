---
implements: specs/3-artifacts/prompts/analyze-failure.spec.md
---

# Analyze LiveSpec Process Failure

Perform forensic analysis when LiveSpec adoption failed - specs drifted, became useless, or weren't maintained. Diagnose what went wrong and provide recovery plan.

## When to Use This

**Use when:**
- Specs and code completely drifted apart
- Team stopped maintaining specifications
- Documentation became outdated/ignored
- LiveSpec process broke down

**Symptoms:**
- "We tried LiveSpec but specs became useless"
- "Specs don't match what code actually does"
- "Team doesn't trust the documentation"
- "We gave up on maintaining specs"

## Analysis Framework

### 1. Evidence Collection

**Check project state:**
```bash
# What specifications exist?
find specs/ -name "*.spec.md" -type f

# When were they last updated?
git log --format="%ai %s" -- specs/

# How much code exists?
find src/ lib/ -name "*" -type f | wc -l

# Recent code changes?
git log --since="1 month ago" --oneline -- src/ lib/ | wc -l
```

**Compare spec update frequency vs. code update frequency.**

### 2. Failure Classification

**Common failure types:**

**A. Specification Abandonment**
- Specs exist but haven't been updated
- Code evolved without spec updates
- Team stopped using Phase 4 (EVOLVE)

**B. Over-Specification**
- Specs too detailed/rigid
- Maintenance burden too high
- Violated MSL minimalism

**C. Wrong Process**
- Skipped Phase 0 (no foundation)
- No workspace specs (no HOW)
- Jumped straight to implementation

**D. No Enforcement**
- No drift detection ran
- No reality checkpoints
- No review gates

### 3. Root Cause Analysis

**System factors:**
- Were prompts unclear?
- Was process too complex?
- Were gaps in methodology?

**Team factors:**
- Was process followed correctly?
- Were prerequisites understood?
- Was buy-in achieved?

**Project factors:**
- Was project scope appropriate?
- Were timelines realistic?
- Did complexity match approach?

## Failure Analysis Report

Create `specs/failure-analysis.md`:

```markdown
# LiveSpec Process Failure Analysis

**Analysis Date**: [YYYY-MM-DD]
**Project**: [Name]
**Failure Type**: [Classification]

## What Happened

[Chronological timeline of failure]

1. [Initial state - when LiveSpec started]
2. [Early signs - when drift began]
3. [Breaking point - when process broke down]
4. [Current state - where we are now]

## Evidence

**Specification Status:**
- Last spec update: [Date]
- Specs created: [Count]
- Specs incomplete: [Count]
- Specs outdated: [List key ones]

**Code Status:**
- Code commits since last spec update: [Count]
- Features not documented: [List]
- Code-spec mismatches: [List critical ones]

**Process Status:**
- Phase 4 (EVOLVE) last run: [Date or "Never"]
- Drift detection: [Never/Rarely/Sometimes]
- Workspace specs: [Exist/Missing]

## Root Causes

**Primary Failure:**
[Main reason the process broke down]

**Contributing Factors:**
1. [Factor] - [How it contributed]
2. [Factor] - [How it contributed]
3. [Factor] - [How it contributed]

## Impact Assessment

**Documentation Quality**: [Score 1-10]
**Team Trust in Specs**: [Low/Medium/High]
**Technical Debt Created**: [Estimate]
**Recovery Effort Required**: [Days/weeks]

## Recovery Plan

### Immediate Actions (This Week)

**Priority 1 - Stop the Bleeding:**
1. [ ] Run `.livespec/4-evolve/4a-detect-drift.md` to document current state
2. [ ] Identify critical specs that MUST be updated
3. [ ] Update PURPOSE.md and specs/1-requirements/strategic/outcomes.spec.md (foundation)

**Priority 2 - Quick Wins:**
1. [ ] Update 3-5 most critical behavior specs
2. [ ] Document major architectural changes
3. [ ] Update workspace specs if missing

### Short-term (This Month)

1. [ ] Run `.livespec/4-evolve/4b-extract-specs.md` on undocumented code
2. [ ] Establish Phase 4 rhythm (weekly/bi-weekly drift checks)
3. [ ] Simplify over-specified areas (embrace MSL minimalism)
4. [ ] Add drift detection to CI/CD if possible

### Long-term (This Quarter)

1. [ ] Team training on MSL minimalism
2. [ ] Establish spec maintenance culture
3. [ ] Automate what can be automated
4. [ ] Regular reality checkpoints (monthly)

## Prevention Recommendations

**Process Changes:**
- Run `4a-detect-drift.md` weekly during active development
- Use `0e-assess-complexity.md` at project start
- Don't skip workspace specs - they define HOW you work
- Embrace MSL minimalism - less is more

**Team Practices:**
- Treat spec updates as part of "done"
- Review specs in PR process
- Regular team checkpoints on spec health
- Celebrate maintained documentation

**Warning Signs to Watch:**
- Specs not updated in 2+ weeks
- Team referring to "actual code" vs. "specs"
- New features not documented
- Drift detection skipped

## Lessons Learned

### What Caused Failure:
- [Key insight about what went wrong]

### What Would Have Prevented It:
- [Specific practice that would have helped]

### What to Do Differently:
- [Concrete change for future]
```

## Common Failure Patterns

### Pattern 1: "We Were Too Detailed"
**Symptoms:** Specs became maintenance burden
**Root Cause:** Violated MSL minimalism
**Fix:** Ruthlessly simplify - keep only CRITICAL/IMPORTANT

### Pattern 2: "We Stopped Updating"
**Symptoms:** Specs drifted silently
**Root Cause:** No Phase 4 rhythm established
**Fix:** Weekly `4a-detect-drift.md`, treat as non-negotiable

### Pattern 3: "We Never Started Properly"
**Symptoms:** No foundation (PURPOSE, requirements, workspace)
**Root Cause:** Skipped Phase 0
**Fix:** Go back to Phase 0, establish foundation

### Pattern 4: "Specs Don't Help Development"
**Symptoms:** Team ignores documentation
**Root Cause:** Specs don't answer real questions
**Fix:** Refocus on behaviors (WHAT) not implementation (HOW)

## Recovery Success Criteria

**After 1 week:**
- [ ] Foundation specs updated (PURPOSE, 1-requirements/strategic/outcomes, architecture)
- [ ] Critical drift documented
- [ ] Recovery plan agreed by team

**After 1 month:**
- [ ] Key behaviors documented
- [ ] Phase 4 rhythm established
- [ ] Team using specs for development

**After 3 months:**
- [ ] Specs trusted by team
- [ ] Drift stays minimal (<10% misalignment)
- [ ] Documentation maintained voluntarily

Remember: Failure is a learning opportunity. Most LiveSpec failures come from over-specification or skipping Phase 4, not from the methodology itself.
