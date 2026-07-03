---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Strategic improvements made without data, repeat failed approaches, known tensions ignored because no one correlates registry state with session patterns
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
specifies: []
---

# Strategic Improvement Analysis

## Requirements

- [!] Agent analyzes accumulated data to identify improvement patterns
  - Reads all three registries (gaps, issues, improvements) as accepted current state
  - Reads recent session feedback (last 10-15 files from `~/.claude/livespec/feedback/`)
  - Analyzes compliance trends (last 5-10 JSON files from `~/.claude/livespec/compliance/`)
  - Correlates known tensions (registry state) with session patterns (same tension in 3+ sessions = systematic)

- [!] Agent prioritizes improvements by impact and frequency
  - Impact levels: CRITICAL (blocks work), HIGH (significant friction), MEDIUM (noticeable), LOW (minor)
  - Frequency levels: Every session, most sessions (>50%), occasional (<50%), rare
  - Priority score = Impact × Frequency (range 1-16)
  - Groups by priority: P1 (12-16), P2 (8-11), P3 (4-7), P4 (1-3)

- [!] Agent checks improvement history before recommending
  - Verifies if similar tension observed before (improvements registry, git history)
  - If previously acted on, identifies what happened
  - Avoids recommending approaches that failed previously
  - Learns from effective changes (what made them work?)

- [!] Agent identifies related items for grouped solutions
  - Same root cause (single solution may address multiple items)
  - Same category (documentation, tooling, process, guidance)
  - Same user impact (all causing delays, all confusing, etc.)

- [!] Agent generates prioritized recommendations
  - P1 (Critical): Address immediately
  - P2 (High): Address soon
  - P3 (Medium): Address when capacity allows
  - P4 (Low): Nice to have
  - Quick wins highlighted (high impact, low effort)
  - Systemic patterns explained (cross-cutting themes)

- [!] Agent updates registries with discoveries
  - New gaps/issues/improvements from pattern analysis (state observations, not work items)
  - Evidence from latest session data added to existing entries
  - Entries whose accepted state has changed are removed (resolved tensions)

- [!] Agent presents actionable recommendations
  - Specific actions (not vague "improve X")
  - Evidence from data (which sessions, how often)
  - Avoidance notes (failed approaches to skip)
  - User choice offered (which priority to tackle)

## Validation

**Data Coverage:**
```bash
# Minimum data requirements
test $(ls -1 ~/.claude/livespec/compliance/*.json 2>/dev/null | wc -l) -ge 5 || echo "Need 5+ compliance files"
test $(ls -1 ~/.claude/livespec/feedback/*.md 2>/dev/null | wc -l) -ge 3 || echo "Need 3+ feedback files"
test -f registries/gaps.md || echo "Need gaps registry"
```

**Prioritization Quality:**
- [ ] All recommendations have priority score (Impact × Frequency)
- [ ] P1 items justified as critical (blocks work or causes failures)
- [ ] Related items grouped (same root cause identified)
- [ ] Quick wins identified (high impact + low effort)

**Improvement History:**
- [ ] Checked registry state and git history before recommending
- [ ] Previously failed approaches noted and avoided
- [ ] Effective patterns referenced ("this worked before")

**Registry Updates:**
- [ ] New state observations added if patterns discovered (not work items)
- [ ] Existing entries updated with latest evidence
- [ ] Resolved tensions removed from registries

## Failure Mode

Without strategic improvement analysis:
- Known tensions sit unreviewed (no one correlates registries with session data)
- Previously failed approaches repeated (no learning from git history)
- Patterns missed (can't see across sessions)
- High-severity tensions ignored (no visibility)
- Low-severity items consume attention over critical ones
