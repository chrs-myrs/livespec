# Improvement Registry

Tracks improvement experiments and their outcomes.

Format: `.livespec/standard/registries/improvements.spec.md`

---

## Current Improvements

### IMP-001: Four-Level Improvement Taxonomy

**Changed:** Established distinct levels (session/context/strategic/diagnostic) with clear terminology and tools

**Hypothesis:** Users confused about when to use which improvement workflow; clear taxonomy with action-focused terms will reduce confusion and increase adoption

**Category:** Structure

**Implemented:** 2025-11-13

**Outcome:** Too early to tell (needs 3-5 sessions to evaluate)

**Evidence Needed:**
- User questions about workflow selection (should decrease)
- Completion of session learnings workflow (should increase)
- Health report usage (baseline to establish)

**Decision:** Keep (pending evaluation)

**Evaluation Date:** 2025-11-20 (1 week), 2025-12-13 (1 month)

---

### IMP-002: Active Session Trigger Logic in AGENTS.md

**Changed:** Converted passive documentation ("agent should detect") to active instructions with specific triggers and prompts to use

**Hypothesis:** Agents not detecting session completion because guidance is passive; active trigger logic with unmissable positioning will increase proactive detection

**Category:** Guidance

**Implemented:** 2025-11-13

**Outcome:** Too early to tell (needs observation across sessions)

**Evidence Needed:**
- Agent proactive recommendations (should increase from ~0% to >70%)
- Session token counts (should decrease, avg <100K)
- User-initiated completions (should decrease as agents recommend)

**Decision:** Keep (pending evaluation)

**Evaluation Date:** 2025-11-20 (immediate impact), 2025-12-13 (sustained)

**Baseline Metrics:**
- Current proactive detection: ~0% (manual only)
- Average session tokens: 127K (evidence: 2025-11-08)
- User-initiated: 100%

---

### IMP-003: Consolidated Learning into Session Completion

**Changed:** Merged "internalise-learnings.md" into "complete-session.md" as Step 6

**Hypothesis:** Two separate prompts created confusion about when to use which; unified workflow will be clearer and increase learning capture

**Category:** Process

**Implemented:** 2025-11-13

**Outcome:** Too early to tell (needs usage pattern observation)

**Evidence Needed:**
- Learning capture rate (how many sessions update specs based on insights)
- User confusion questions (should decrease)
- LiveSpec feedback quality (should improve with consistent capture)

**Decision:** Keep (pending evaluation)

**Evaluation Date:** 2025-11-20 (1 week), 2025-12-13 (1 month)

**Related:** IMP-001 (part of larger taxonomy improvement)

---

### IMP-004: Registry-Based Improvement Tracking

**Changed:** Created three registries (gaps, issues, improvements) to systematically track problems and solutions

**Hypothesis:** Ad-hoc improvement without tracking leads to repeated failures and unclear effectiveness; registries will enable pattern detection and prevent repeating mistakes

**Category:** Process

**Implemented:** 2025-11-13

**Outcome:** Too early to tell (this is self-referential - tracking itself)

**Evidence Needed:**
- Registry usage (are gaps/issues being added?)
- Pattern detection (do registries reveal trends?)
- Prevented repetition (do we avoid trying failed approaches?)
- Strategic improvement quality (better prioritization with registry data?)

**Decision:** Keep (pending evaluation)

**Evaluation Date:** 2025-12-13 (1 month - needs time to accumulate data)

**Meta Note:** This improvement tracks itself - effectiveness measured by registry utility

---

## Evaluation Guidelines

### Immediate Impact (1 week)
- Observable behavior changes
- User/agent confusion reduction
- Workflow adoption rates

### Sustained Impact (1 month)
- Pattern consistency
- Productivity improvements
- Quality improvements (specs, decisions, compliance)

### Long-term Impact (3 months)
- Methodology maturity
- User satisfaction
- Reduced friction
- Framework stability

### Evidence Types
- **Quantitative:** Metrics, counts, scores, percentages
- **Qualitative:** User feedback, session observations, agent behavior
- **Comparative:** Before/after measurements, baseline vs current

---

## Maintenance

**Update:** When implemented, at evaluation dates, when decision made
**Review:** Evaluation date reached, user feedback, quarterly review
**Archive:** Only if fully reverted AND lessons extracted
