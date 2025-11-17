---
criticality: IMPORTANT
failure_mode: Try improvements without tracking effectiveness, repeat failed approaches, no learning from experiments
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
---

# Improvement Tracking Registry

## Requirements

- [!] Registry MUST track improvements tried and their results
  - Each improvement includes: what changed, hypothesis (why we thought it would help), outcome, decision
  - Changes categorized: process, tooling, documentation, structure, guidance
  - Outcome tracked: effective, ineffective, mixed, too early to tell
  - Decision recorded: keep, revert, iterate

- [!] Improvement entries MUST support learning from experiments
  - Hypothesis states expected benefit (measurable if possible)
  - Outcome describes actual impact (with evidence if available)
  - Decision justified based on outcome
  - No "tried something" entries without evaluation

- [!] Registry MUST prevent repeating failed approaches
  - Ineffective improvements retained in registry (with why they failed)
  - Related improvements linkable (same goal, different approach)
  - "Iterate" decision includes what to adjust next time
  - Reconsideration triggers documented (when might we retry?)

- [!] Registry MUST be maintained through defined workflows
  - Updated by: Suggest Improvements (when implementing changes)
  - Evaluated after: 1 week (immediate impact), 1 month (sustained impact), 3 months (long-term)
  - Status transitions: proposed → implemented → evaluating → effective/ineffective/mixed
  - Ineffective improvements analyzed for lessons learned

## Validation

**Improvement Entry Completeness:**
```bash
# Each improvement must have required fields
cat specs/3-behaviors/registries/improvements.spec.md | grep -A 10 "^### IMP-" | \
  grep -E "(Changed|Hypothesis|Outcome|Decision)" | wc -l
# Should be 4× number of improvements
```

**Hypothesis Quality:**
```bash
# No vague hypotheses
! grep -i "will be better" specs/3-behaviors/registries/improvements.spec.md
! grep -i "should improve" specs/3-behaviors/registries/improvements.spec.md | grep -v "specific metric"
```

**Decision Justification:**
```bash
# All keep/revert decisions have justification
cat specs/3-behaviors/registries/improvements.spec.md | \
  grep -E "(Decision: keep|Decision: revert)" | while read dec; do
  grep -A 3 "$dec" specs/3-behaviors/registries/improvements.spec.md | \
    grep "Reasoning:" >/dev/null || echo "Decision missing justification: $dec"
done
```

## Failure Mode

Without improvement tracking:
- Repeat failed approaches (no institutional memory)
- Unclear if changes actually helped (no measurement)
- Good improvements reverted accidentally (no evidence)
- No learning from experiments (try-fail-forget cycle)
- Improvement fatigue (change without benefit)

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

## Registry Maintenance

**Update Frequency:**
- When improvements implemented (initial entry)
- At evaluation dates (update outcome)
- When decision made (keep/revert/iterate)

**Review Triggers:**
- Evaluation date reached
- User feedback about improvement
- Validation reveals impact
- Quarterly improvement effectiveness review

**Archival Policy:**
- Keep "effective" improvements (success stories)
- Keep "ineffective" improvements (prevent repetition)
- Keep "mixed" improvements (document nuance)
- Only archive if improvement fully reverted AND lessons extracted

---

*This registry tracks LiveSpec's own improvement experiments, creating institutional memory and preventing repeated mistakes.*
