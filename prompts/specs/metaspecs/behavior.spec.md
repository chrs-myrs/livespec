---
criticality: CRITICAL
failure_mode: Without behavior spec requirements, behavioral specs become implementation details rather than observable outcomes
constrained_by:
  - .livespec/specs/metaspecs/base.spec.md
---

# Behavior Specification Requirements

## Requirements
- [!] Behavior specifications define observable system behaviors from user perspective, with validation criteria.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/behaviors/` folder
  - Requirement statement describes WHAT system does (observable outcome)
  - Requirement is user-facing or externally observable
  - Requirement includes validation criteria (how to verify)
  - Spec does NOT include implementation details (no "how")
  - Spec does NOT include internal technical decisions
  - File name describes the behavior (e.g., `user-authentication.spec.md`)
  - One behavior per spec file (no combining multiple behaviors)

## Notes

**Good behavior requirements:**
- ✅ "System authenticates users via email and password"
- ✅ "API returns paginated results for list endpoints"
- ✅ "Users can export data in CSV format"

**Not behavior requirements:**
- ❌ "Use bcrypt for password hashing" (implementation detail → strategy spec)
- ❌ "Database stores user credentials" (internal detail → strategy spec)
- ❌ "Follow REST conventions" (technical decision → workspace spec)

**Validation criteria must be:**
- Observable (can be tested or inspected)
- Specific (no vague terms like "good" or "fast")
- Complete (cover all aspects of the behavior)

Behavior specs go in target project's `specs/behaviors/` folder.
