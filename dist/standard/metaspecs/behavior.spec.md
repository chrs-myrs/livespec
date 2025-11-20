---
criticality: CRITICAL
failure_mode: Without behavior spec requirements, behavioral specs become implementation details rather than observable outcomes
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Behavior Specification Requirements

## Requirements
- [!] Behavior specifications define observable outcomes from any perspective, with validation criteria.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/3-behaviors/` folder or subfolder
  - **Subfolders encouraged** for domain organization (behaviors/policies/, behaviors/user-features/, behaviors/services/)
  - Requirement statement describes WHAT is observable (not HOW it works)
  - Requirement is externally observable (users, systems, auditors, or stakeholders can verify)
  - Requirement includes validation criteria (how to verify the outcome)
  - Spec does NOT include implementation details (no "how")
  - Spec does NOT include internal technical decisions
  - File name describes the behavior (e.g., `user-authentication.spec.md`)
  - One behavior per spec file (no combining multiple behaviors)

## Behavior vs Contract Boundary

**Critical distinction**: Behaviors describe OUTCOMES, contracts describe INTERFACES.

**Behaviors answer**: "What should happen when...?"
- ✅ "System posts messages to Slack channels"
- ✅ "Thread replies appear under parent message"
- ✅ "Invalid credentials rejected with error"

**Contracts answer**: "What does the API/function/interface look like?"
- ✅ `slack_post_message(channel, text, thread_ts?)` parameter schema
- ✅ `POST /auth/login` request/response format
- ✅ Error response structure: `{ ok: false, error: string }`

**Every contract parameter MUST link to behavior spec** (enforced by scripts/check-contract-completeness.sh)

**Example linkage**:
```markdown
# Contract: specs/3-contracts/mcp-tools/slack.spec.md
Parameters:
- thread_ts (optional): Parent message timestamp
  - Behavior: specs/3-behaviors/threading.spec.md#thread-replies
```

**Common mistakes**:
- ❌ Putting interface details in behavior spec (API endpoints, schemas, parameter types)
- ❌ Putting behavior logic in contract spec (validation rules, business logic)
- ❌ Contract parameters without behavior links (incomplete feature)

**See Reference Library**: `behavior-contract-boundary.md` for complete decision framework.

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
├── dev-environment/       # Development setup domain
│   ├── mcp-integration.spec.md
│   └── local-dependencies.spec.md
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
