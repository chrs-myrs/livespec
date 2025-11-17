---
criticality: IMPORTANT
failure_mode: Methodology gaps accumulate without tracking, same issues repeat across sessions, no systematic improvement of LiveSpec framework
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
---

# Methodology Gap Registry

## Requirements

- [!] Registry MUST track identified gaps in LiveSpec methodology
  - Each gap entry includes: description, impact assessment, potential solution, discovery date
  - Gaps organized by category (process, tooling, documentation, guidance)
  - Status tracked: identified, investigating, planned, resolved
  - Discovery source recorded (session ID, user feedback, validation)

- [!] Gap entries MUST be actionable and specific
  - Description states what is missing or inadequate
  - Impact quantifies cost of gap (frequency, severity, affected users)
  - Potential solution proposes concrete improvement
  - No vague "make X better" entries without specifics

- [!] Registry MUST support strategic improvement prioritization
  - Impact categories: CRITICAL (blocks work), HIGH (significant friction), MEDIUM (minor friction), LOW (nice-to-have)
  - Frequency tracked: every session, most sessions, occasional, rare
  - Priority calculated from impact × frequency
  - Related gaps linkable (same root cause)

- [!] Registry MUST be maintained through defined workflows
  - Updated by: Capture Session Learnings (immediate gaps), Suggest Improvements (pattern analysis)
  - Reviewed by: Suggest Improvements prompt (monthly or when 10+ gaps accumulated)
  - Status transitions tracked: identified → investigating → planned → resolved
  - Resolved gaps archived with solution summary

## Validation

**Gap Entry Completeness:**
```bash
# Each gap entry must have all required fields
cat specs/3-behaviors/registries/gaps.spec.md | grep -A 10 "^### GAP-" | \
  grep -E "(Description|Impact|Solution|Status)" | wc -l
# Should be 4× number of gaps
```

**Actionability Check:**
```bash
# No vague entries
! grep -i "make.*better" specs/3-behaviors/registries/gaps.spec.md
! grep -i "improve.*generally" specs/3-behaviors/registries/gaps.spec.md
```

**Prioritization Coverage:**
```bash
# All gaps have impact and frequency
cat specs/3-behaviors/registries/gaps.spec.md | grep "^### GAP-" | while read gap; do
  grep -A 10 "$gap" specs/3-behaviors/registries/gaps.spec.md | \
    grep -E "(Impact|Frequency)" >/dev/null || echo "Missing priority data: $gap"
done
```

## Failure Mode

Without methodology gap tracking:
- Same issues repeat across sessions (no learning)
- High-impact gaps never addressed (no visibility)
- Improvement efforts scattered (no prioritization)
- User frustrations accumulate (no systematic resolution)
- LiveSpec stagnates (no feedback loop)

---

## Current Gaps

### GAP-001: Agent Session Prompting

**Description:** Agents don't proactively detect session completion triggers despite documentation describing this behavior

**Impact:** HIGH - Sessions run too long (>100K tokens), context degrades, users manually manage sessions

**Frequency:** Most sessions (evidence: 2025-11-08 feedback shows 127K token session)

**Potential Solution:** Add active trigger logic to AGENTS.md with specific detection criteria and prompts agents should use

**Status:** Planned (part of 2025-11-13 improvement initiative)

**Discovered:** 2025-11-13 during terminology standardization analysis

---

### GAP-002: Learning Terminology Confusion

**Description:** Multiple overlapping terms for learning workflows ("internalise learnings", "self-improvement", "framework evolution") with unclear distinction

**Impact:** MEDIUM - Users and agents confused about when to use which workflow

**Frequency:** Occasional (appears in user questions about methodology)

**Potential Solution:** Establish four-level improvement taxonomy with clear terminology and scope

**Status:** Planned (part of 2025-11-13 improvement initiative)

**Discovered:** 2025-11-13 user feedback during terminology discussion

---

### GAP-003: No Cross-Session Pattern Analysis

**Description:** Session completion saves feedback to `~/.claude/livespec/feedback/` but no tool aggregates or analyzes patterns across sessions

**Impact:** HIGH - Repeated issues invisible, methodology improvements require manual review of dozens of files

**Frequency:** Every session (data saved but never aggregated)

**Potential Solution:** Create "Suggest Improvements" prompt that reads feedback files and identifies patterns

**Status:** Planned (part of 2025-11-13 improvement initiative)

**Discovered:** 2025-11-13 during improvement taxonomy research

---

### GAP-004: No Unified Health Dashboard

**Description:** 8 validation scripts exist but no single tool aggregates results into RED/YELLOW/GREEN status with remediation recommendations

**Impact:** MEDIUM - Users must run individual checks, no "at a glance" health view

**Frequency:** Before releases, weekly checks

**Potential Solution:** Create "Run Health Report" prompt that executes all validations and synthesizes results

**Status:** Planned (part of 2025-11-13 improvement initiative)

**Discovered:** 2025-11-13 during improvement taxonomy research

---

## Registry Maintenance

**Update Frequency:**
- After every session (if gaps identified during session completion)
- Monthly (during strategic improvement analysis)
- After validation runs (if systemic issues detected)

**Review Triggers:**
- 10+ identified gaps accumulated
- Same gap appears in 3+ sessions
- CRITICAL impact gap identified
- Monthly strategic review

**Archival Policy:**
- Resolved gaps moved to `.archive/gaps-resolved-YYYY-MM.md`
- Archive includes solution summary and effectiveness notes
- Archived gaps reviewed if related issues re-emerge

---

*This registry is maintained through automated workflows (Capture Session Learnings, Suggest Improvements) and manual additions when gaps discovered.*
