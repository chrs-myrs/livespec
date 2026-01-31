---
purpose: Quick decision tree for evaluating research value
estimated_time: "5 minutes"
---

# Research Decision Tree

**Purpose**: Quickly determine if research will add value to your project

**When to use**: During Phase 0e (Evaluate Research Needs) when unsure if research is worth the investment

## The Decision Tree

```
START: Should I invest time in research?
│
├─ Is this a safety-critical or accessibility domain?
│  (Medical, financial, accessibility, child users, safety-critical)
│  ├─ YES → ✅ Research MANDATORY (legal/safety requirement)
│  └─ NO → Continue...
│
├─ Do I truly understand my users' workflows?
│  ├─ YES, documented → Skip research (low value)
│  ├─ THINK SO → ⚠️  Danger zone - continue...
│  └─ NO → Continue...
│
├─ Developer platform?
│  ├─ YES → Is API surface complex?
│  │   ├─ YES → ✅ Research HIGH priority (API UX flow, developer persona)
│  │   └─ NO, simple wrapper → ⏭️  Research SKIP OK (document assumptions)
│  └─ NO → Continue...
│
├─ User-facing application?
│  ├─ YES → Are workflows cross-touchpoint or multi-step?
│  │   ├─ YES → ✅ Research HIGH priority (journey map, UX flows)
│  │   └─ NO, simple CRUD → ⏭️  Research LOW priority (standard patterns apply)
│  └─ NO → Continue...
│
├─ Infrastructure or backend system?
│  ├─ YES → ⏭️  Research SKIP OK (technical spike instead)
│  └─ NO → Continue...
│
├─ Are requirements based on assumptions?
│  ├─ YES → ✅ Research MEDIUM-HIGH priority (validate assumptions)
│  └─ NO, evidence-based → ⏭️  Research SKIP OK
│
└─ Default: ✅ Research MEDIUM priority (better safe than sorry)
```

## Quick Reference

| Project Type | Typical Research Need | Why |
|--------------|----------------------|-----|
| **Safety-critical** | ✅ MANDATORY | Legal/safety requirement |
| **Accessibility** | ✅ MANDATORY | Legal compliance, user safety |
| **Complex developer platform** | ✅ HIGH | API UX, developer workflows |
| **Multi-step user workflows** | ✅ HIGH | Journey mapping catches gaps |
| **User-facing app** | ✅ MEDIUM-HIGH | UX flows, error states |
| **Internal tool** | ⚠️  MEDIUM | Stakeholder alignment |
| **Simple CRUD** | ⏭️  LOW | Standard patterns apply |
| **Infrastructure/backend** | ⏭️  SKIP OK | Technical spike instead |

## Real Examples

### Example 1: slackward (Developer Platform)
**Initial assumption**: "Simple developer tool, research seems excessive"
**Decision tree path**: Developer platform → Complex API → Research HIGH
**Result**: Journey mapping caught concurrent approvals as day-one requirement (would have deferred to v2)
**Verdict**: ✅ Research saved architectural rework

### Example 2: Simple CRUD App
**Project**: Basic inventory tracking for small business
**Decision tree path**: User-facing → Simple CRUD → Research LOW
**Result**: Skip formal research, validate during build
**Verdict**: ⏭️  Time saved, standard patterns applied

### Example 3: Medical Appointment System
**Project**: Scheduling system for clinic
**Decision tree path**: Safety-critical (medical domain) → Research MANDATORY
**Result**: Must conduct research regardless of "obviousness"
**Verdict**: ✅ Legal compliance requires evidence-based design

## When "I Think I Know" Is Dangerous

**Red flags that research is needed even if you "know" users:**

- ❌ "I'm the user" (your workflow ≠ others' workflows)
- ❌ "It's obvious how this works" (edge cases aren't obvious)
- ❌ "This is industry standard" (standards vary, users have unique contexts)
- ❌ "We'll validate during beta" (costly to fix architectural issues post-build)

**Green flags that skipping research is OK:**

- ✅ Formal research conducted < 6 months ago for same user base
- ✅ Backend system with defined contract from external spec
- ✅ Infrastructure project with no direct users
- ✅ Replicating existing system with documented requirements

## Cost-Benefit Quick Check

**Research investment**: 2-8 hours (personas, journeys, flows)
**Rework cost if wrong**: 2-10 days (architectural changes, reimplementation)

**Break-even**: If there's >10% chance research catches a critical requirement, it's worth it.

## Decision Shortcuts

**Skip research if ALL of these are true:**
- [ ] No user workflows involved (pure backend/infrastructure)
- [ ] Requirements fully documented from prior work
- [ ] No legal/safety requirements
- [ ] Standard patterns apply (CRUD, REST API)

**Do research if ANY of these are true:**
- [ ] Safety-critical or accessibility domain
- [ ] User workflows span multiple steps/systems
- [ ] Requirements based on assumptions
- [ ] Novel UX patterns (no established conventions)
- [ ] Multiple user types with different needs

## Next Steps

After using this decision tree:

**If research recommended:**
→ Proceed with 0e-evaluate-research-needs.md
→ Use templates in `.livespec/templates/research/`
→ Follow metaspecs in `.livespec/standard/metaspecs/research/`

**If research skipped:**
→ Document assumptions in requirements
→ Note validation approach for later
→ Proceed to 0f-identify-constraints.md

**Remember**: Research isn't about thoroughness - it's about catching expensive mistakes early.
