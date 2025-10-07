---
criticality: CRITICAL
failure_mode: Without constraint spec rules, hard boundaries become vague requirements or mix with preferences
constrained_by:
  - livespec-standard/metaspecs/base.spec.md
---

# Constraints Specification Requirements

## Requirements
- [!] Constraints specification defines hard boundaries that solution must respect (non-negotiable limits).
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located at `specs/constraints.spec.md` (root specs folder)
  - Each constraint is a hard boundary (violating it = project fails)
  - Each constraint is testable and measurable
  - Constraints do NOT include preferences or "nice-to-haves"
  - Constraints do NOT include functional requirements (→ requirements/behavior specs)
  - Constraints do NOT include technical decisions (→ strategy spec)
  - Each constraint includes validation criteria (how to verify compliance)
  - Constraint statement is specific (no vague terms like "fast" or "secure")

## Notes

**Purpose of constraints.spec.md:**
- Captures non-negotiable boundaries
- Derived from PURPOSE.md or external factors
- Constrains architecture and strategy
- Often from: regulations, budgets, existing systems, physics

**Good constraints:**
- ✅ "Response time <200ms for 95th percentile" (testable limit)
- ✅ "Must comply with GDPR data residency" (legal boundary)
- ✅ "Works on existing PostgreSQL 12 database" (compatibility limit)
- ✅ "Budget limit: $1000/month cloud costs" (resource boundary)

**Not constraints:**
- ❌ "Should be fast" (too vague, use requirements or omit)
- ❌ "Users can search documents" (functional requirement → behavior spec)
- ❌ "Use Redis for caching" (technical decision → strategy spec)

**Test:** Can the project succeed without this constraint?
- If YES → It's not a constraint (remove or move to requirements)
- If NO → It's a constraint (keep it)

**Relationship to other specs:**
```
PURPOSE.md + External factors
    ↓ identifies
constraints.spec.md (hard boundaries)
    ↓ constrains
strategy/architecture.spec.md (must respect constraints)
```

Constraints spec goes in target project's `specs/` root folder.
