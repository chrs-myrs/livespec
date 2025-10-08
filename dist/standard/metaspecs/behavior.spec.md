---
criticality: CRITICAL
failure_mode: Without behavior spec requirements, behavioral specs become implementation details rather than observable outcomes
constrained_by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Behavior Specification Requirements

## Requirements
- [!] Behavior specifications define observable outcomes from any perspective, with validation criteria.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/behaviors/` folder or subfolder
  - **Subfolders encouraged** for domain organization (behaviors/policies/, behaviors/user-features/, behaviors/services/)
  - Requirement statement describes WHAT is observable (not HOW it works)
  - Requirement is externally observable (users, systems, auditors, or stakeholders can verify)
  - Requirement includes validation criteria (how to verify the outcome)
  - Spec does NOT include implementation details (no "how")
  - Spec does NOT include internal technical decisions
  - File name describes the behavior (e.g., `user-authentication.spec.md`)
  - One behavior per spec file (no combining multiple behaviors)

## Notes

**Behaviors apply across domains:**

**Software Development:**
- ✅ "System authenticates users via email and password"
- ✅ "API returns paginated results for list endpoints"
- ✅ "Users can export data in CSV format"

**Governance:**
- ✅ "Only authorized entities can access resources" (policy behavior)
- ✅ "Incidents reported within 72 hours" (compliance behavior)
- ✅ "Access reviews conducted quarterly" (governance behavior)

**Operations:**
- ✅ "System responds to alerts within 5 minutes" (operational behavior)
- ✅ "Backups complete daily before 06:00" (service behavior)

**Planning:**
- ✅ "Problem solved when success criteria met" (requirement behavior)

**Not behavior requirements:**
- ❌ "Use bcrypt for password hashing" (implementation detail → strategy spec)
- ❌ "Database stores user credentials" (internal detail → strategy spec)
- ❌ "Follow REST conventions" (technical decision → workspace spec)

**Validation criteria must be:**
- Observable (can be tested, audited, or inspected)
- Specific (no vague terms like "good" or "fast")
- Complete (cover all aspects of the behavior)

**Organization patterns:**
```
specs/behaviors/
├── user-features/         # Software domain
│   ├── authentication.spec.md
│   └── authorization.spec.md
├── policies/              # Governance domain
│   ├── access-control.spec.md
│   └── data-protection.spec.md
├── services/              # Operations domain
│   ├── backup.spec.md
│   └── monitoring.spec.md
└── prompts/               # Methodology domain (LiveSpec's own)
    ├── 0a-setup-workspace.spec.md
    └── 4a-detect-drift.spec.md
```
