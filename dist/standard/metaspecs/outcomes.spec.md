---
criticality: CRITICAL
failure_mode: Without outcomes spec rules, high-level requirements become detailed behaviors or mix with constraints
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Outcomes Specification Requirements

## Requirements
- [!] Outcomes specification captures high-level project requirements (what must be achieved) that behaviors and architecture must satisfy.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located at `specs/mission/outcomes.spec.md`
  - Requirements are high-level (not detailed behaviors)
  - Requirements describe WHAT must be achieved (outcomes, not features)
  - Requirements trace to PURPOSE.md (why this project exists)
  - Requirements do NOT include implementation details
  - Requirements do NOT include hard boundaries (→ constraints spec)
  - Requirements do NOT include observable behaviors (→ behavior specs)
  - Each requirement is testable (can verify if satisfied)
  - Requirement statement is concise (one sentence)
  - Behaviors in `specs/behaviors/` should trace back to these outcomes

## Notes

**Purpose of outcomes.spec.md:**
- Captures "what we must achieve" at high level
- Derived from PURPOSE.md
- Parent of behavior and strategy specs
- Provides traceability from purpose to implementation

**Good outcomes:**
- ✅ "Enable users to collaborate on shared documents"
- ✅ "Process payments securely and reliably"
- ✅ "Support mobile and desktop access"

**Not outcomes:**
- ❌ "Users can create, edit, delete documents" (too detailed → behavior spec)
- ❌ "Must use HTTPS" (constraint → constraints spec)
- ❌ "Use React for frontend" (technical decision → strategy spec)

**Relationship to other specs:**
```
PURPOSE.md (why - vision)
    ↓ derives
specs/mission/outcomes.spec.md (what - high-level requirements)
specs/mission/constraints.spec.md (limits - hard boundaries)
    ↓ both inform
specs/strategy/architecture.spec.md (how - technical approach)
    ↓ implements
specs/behaviors/*.spec.md (what - detailed behaviors)
```

Outcomes spec goes in target project's `specs/mission/` folder.
