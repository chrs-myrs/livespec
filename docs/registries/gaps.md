# Gap Registry

Tracks methodology gaps identified during LiveSpec development.

Format: `.livespec/standard/registries/gaps.spec.md`

---

## Current Gaps

### GAP-001: Agent Session Prompting

**Description:** Agents don't proactively detect session completion triggers despite documentation describing this behavior

**Impact:** HIGH - Sessions run too long (>100K tokens), context degrades, users manually manage sessions

**Frequency:** Most sessions (evidence: 2025-11-08 feedback shows 127K token session)

**Potential Solution:** Add active trigger logic to AGENTS.md with specific detection criteria and prompts agents should use

**Status:** Accepted Limitation ✓

**Discovered:** 2025-11-13 during terminology standardization analysis

**Resolution (2025-12-15):** Accepted as limitation. IMP-002 attempted trigger logic but was ineffective (1/18 sessions). Stronger enforcement would compete with more critical guidance (spec-first). Session completion remains user-initiated via `/livespec:complete-session` slash command. When users do complete sessions, the workflow works well (IMP-003 effective). This is acceptable.

---

### GAP-002: Learning Terminology Confusion

**Description:** Multiple overlapping terms for learning workflows ("internalise learnings", "self-improvement", "framework evolution") with unclear distinction

**Impact:** MEDIUM - Users and agents confused about when to use which workflow

**Frequency:** Occasional (appears in user questions about methodology)

**Potential Solution:** Establish four-level improvement taxonomy with clear terminology and scope

**Status:** Resolved ✓

**Discovered:** 2025-11-13 user feedback during terminology discussion

**Resolution (2025-12-15):** IMP-001 implemented taxonomy and was effective - no terminology confusion reported in 18 feedback files since Nov 13. Closing this gap.

---

### GAP-003: No Cross-Session Pattern Analysis

**Description:** Session completion saves feedback to `~/.claude/livespec/feedback/` but no tool aggregates or analyzes patterns across sessions

**Impact:** HIGH - Repeated issues invisible, methodology improvements require manual review of dozens of files

**Frequency:** Every session (data saved but never aggregated)

**Potential Solution:** Create "Suggest Improvements" prompt that reads feedback files and identifies patterns

**Status:** Resolved ✓

**Discovered:** 2025-11-13 during improvement taxonomy research

**Resolution (2025-12-15):** `dist/prompts/utils/suggest-improvements.md` prompt created and working. This very analysis used it to read 25 compliance records and 18 feedback files, detecting patterns and evaluating improvement effectiveness. Gap closed.

---

### GAP-004: No Unified Health Dashboard

**Description:** 8 validation scripts exist but no single tool aggregates results into RED/YELLOW/GREEN status with remediation recommendations

**Impact:** MEDIUM - Users must run individual checks, no "at a glance" health view

**Frequency:** Before releases, weekly checks

**Potential Solution:** Create "Run Health Report" prompt that executes all validations and synthesizes results

**Status:** Resolved ✓

**Discovered:** 2025-11-13 during improvement taxonomy research

**Resolution (2025-12-15):** `dist/prompts/utils/run-health-report.md` prompt exists and is functional. Also referenced via `/livespec:health-report` slash command. Gap closed.

---

## Resolved Gaps (Archived 2025-12-15)

- **GAP-001:** Agent Session Prompting → Accepted as limitation (user-initiated by design)
- **GAP-002:** Learning Terminology Confusion → IMP-001 effective
- **GAP-003:** No Cross-Session Pattern Analysis → suggest-improvements.md implemented
- **GAP-004:** No Unified Health Dashboard → run-health-report.md implemented

---

## Maintenance

**Update:** After sessions (if gaps identified), monthly strategic review
**Review:** 10+ gaps, same gap 3+ times, CRITICAL impact, monthly
**Archive:** Resolved gaps to `.archive/gaps-resolved-YYYY-MM.md`
