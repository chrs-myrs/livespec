---
criticality: CRITICAL
failure_mode: Without requirements spec rules, high-level requirements become detailed behaviors or mix with constraints
constrained_by:
  - .livespec/specs/metaspecs/base.spec.md
---

# Requirements Specification Requirements

## Requirements
- [!] Requirements specification captures high-level project requirements that behaviors and architecture must satisfy.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located at `specs/requirements.spec.md` (root specs folder)
  - Requirements are high-level (not detailed behaviors)
  - Requirements describe WHAT must be achieved (outcomes, not features)
  - Requirements trace to PURPOSE.md (why this project exists)
  - Requirements do NOT include implementation details
  - Requirements do NOT include hard boundaries (→ constraints spec)
  - Requirements do NOT include observable behaviors (→ behavior specs)
  - Each requirement is testable (can verify if satisfied)
  - Requirement statement is concise (one sentence)
  - Behaviors in `specs/behaviors/` should trace back to these requirements

## Notes

**Purpose of requirements.spec.md:**
- Captures "what we must achieve" at high level
- Derived from PURPOSE.md
- Parent of behavior and strategy specs
- Provides traceability from purpose to implementation

**Good requirements:**
- ✅ "Enable users to collaborate on shared documents"
- ✅ "Process payments securely and reliably"
- ✅ "Support mobile and desktop access"

**Not requirements:**
- ❌ "Users can create, edit, delete documents" (too detailed → behavior spec)
- ❌ "Must use HTTPS" (constraint → constraints spec)
- ❌ "Use React for frontend" (technical decision → strategy spec)

**Relationship to other specs:**
```
PURPOSE.md (why)
    ↓ derives
requirements.spec.md (what outcomes)
    ↓ satisfies
├── behaviors/*.spec.md (detailed user behaviors)
└── strategy/architecture.spec.md (how technically)
```

Requirements spec goes in target project's `specs/` root folder.
