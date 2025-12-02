---
criticality: IMPORTANT
failure_mode: Methodology gaps accumulate without tracking, same issues repeat across sessions
---

# Gap Registry Format

Defines the format for tracking methodology gaps in `docs/registries/gaps.md`.

## Requirements

- [!] Each gap entry MUST follow standard format
  - ID pattern: `GAP-[NNN]` (e.g., GAP-001, GAP-002)
  - Required fields: Description, Impact, Frequency, Potential Solution, Status, Discovered
  - All fields populated (no empty required fields)

- [!] Impact MUST use defined severity levels
  - CRITICAL: Blocks work, immediate attention required
  - HIGH: Significant friction, address soon
  - MEDIUM: Minor friction, address when possible
  - LOW: Nice-to-have improvement

- [!] Frequency MUST use defined values
  - every session: Encountered in most/all sessions
  - most sessions: Encountered frequently
  - occasional: Encountered sometimes
  - rare: Encountered infrequently

- [!] Status MUST use defined transitions
  - identified: Gap discovered, not yet investigated
  - investigating: Actively analyzing root cause and solutions
  - planned: Solution identified, scheduled for implementation
  - resolved: Solution implemented (move to archive)

- [!] Category SHOULD group related gaps
  - process: Workflow or methodology gaps
  - tooling: Missing or inadequate tools
  - documentation: Missing or unclear guidance
  - guidance: Agent behavior gaps

## Entry Format

```markdown
### GAP-[NNN]: [Title]

**Description:** [What is missing or inadequate]

**Impact:** [CRITICAL/HIGH/MEDIUM/LOW] - [Brief explanation of impact]

**Frequency:** [every session/most sessions/occasional/rare]

**Potential Solution:** [Proposed concrete improvement]

**Status:** [identified/investigating/planned/resolved]

**Discovered:** [YYYY-MM-DD] [context]

---
```

## Validation

**Entry completeness:**
```bash
cat docs/registries/gaps.md | grep -A 10 "^### GAP-" | \
  grep -E "(Description|Impact|Frequency|Solution|Status|Discovered)" | wc -l
# Should be 6x number of gaps
```

**No vague entries:**
```bash
! grep -i "make.*better" docs/registries/gaps.md
! grep -i "improve.*generally" docs/registries/gaps.md
```

## Maintenance

**Update triggers:**
- After session completion (if gaps identified)
- After validation runs (if systemic issues detected)
- During strategic improvement analysis

**Review triggers:**
- 10+ identified gaps accumulated
- Same gap appears in 3+ sessions
- CRITICAL impact gap identified
- Monthly strategic review

**Archival:**
- Resolved gaps move to `.archive/gaps-resolved-YYYY-MM.md`
- Include solution summary and effectiveness notes

## Failure Mode

Without gap tracking:
- Same issues repeat across sessions (no learning)
- High-impact gaps never addressed (no visibility)
- Improvement efforts scattered (no prioritization)
