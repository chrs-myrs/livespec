---
criticality: IMPORTANT
failure_mode: Try improvements without tracking effectiveness, repeat failed approaches, no learning from experiments
---

# Improvement Registry Format

Defines the format for tracking improvement experiments in `docs/registries/improvements.md`.

## Requirements

- [!] Each improvement entry MUST follow standard format
  - ID pattern: `IMP-[NNN]` (e.g., IMP-001, IMP-002)
  - Required fields: Changed, Hypothesis, Category, Implemented, Outcome, Decision
  - All fields populated (no empty required fields)

- [!] Status MUST use defined transitions
  - proposed: Improvement identified, not yet implemented
  - implemented: Change made, awaiting evaluation
  - evaluating: Actively measuring impact
  - effective: Proven beneficial, keeping
  - ineffective: Did not help, lessons extracted
  - mixed: Partial success, may iterate

- [!] Decision MUST record outcome
  - keep: Improvement effective, retain
  - revert: Improvement ineffective, undo
  - iterate: Partial success, try modified approach

- [!] Category MUST group related improvements
  - process: Workflow changes
  - tooling: Tool additions or modifications
  - documentation: Docs improvements
  - structure: Organization changes
  - guidance: Agent behavior changes

- [!] Improvement entries MUST support learning
  - Hypothesis: States expected benefit (measurable if possible)
  - Outcome: Describes actual impact with evidence
  - Ineffective improvements retained to prevent repetition

## Entry Format

```markdown
### IMP-[NNN]: [Title]

**Changed:** [What was modified]

**Hypothesis:** [Expected benefit and why]

**Category:** [process/tooling/documentation/structure/guidance]

**Implemented:** [YYYY-MM-DD]

**Outcome:** [effective/ineffective/mixed/too early to tell]

**Evidence:** [What we observed, metrics if available]

**Decision:** [keep/revert/iterate] - [Justification]

**Evaluation Date:** [When to assess: 1 week, 1 month, 3 months]

**Related:** [Links to related improvements, gaps, or issues]

---
```

## Validation

**Entry completeness:**
```bash
cat docs/registries/improvements.md | grep -A 12 "^### IMP-" | \
  grep -E "(Changed|Hypothesis|Category|Implemented|Outcome|Decision)" | wc -l
# Should be 6x number of improvements
```

**No vague hypotheses:**
```bash
! grep -i "will be better" docs/registries/improvements.md
! grep -i "should improve" docs/registries/improvements.md | grep -v "metric"
```

**Decision justification:**
```bash
cat docs/registries/improvements.md | \
  grep -E "(Decision: keep|Decision: revert)" | while read dec; do
  echo "$dec" | grep -q "-" || echo "Decision missing justification"
done
```

## Evaluation Timeline

- **1 week:** Observable behavior changes, immediate friction reduction
- **1 month:** Pattern consistency, productivity improvements
- **3 months:** Methodology maturity, sustained benefits

## Maintenance

**Update triggers:**
- When improvements implemented (initial entry)
- At evaluation dates (update outcome)
- When decision made (keep/revert/iterate)

**Review triggers:**
- Evaluation date reached
- User feedback about improvement
- Quarterly effectiveness review

**Archival:**
- Keep "effective" improvements (success stories)
- Keep "ineffective" improvements (prevent repetition)
- Only archive if fully reverted AND lessons extracted

## Failure Mode

Without improvement tracking:
- Repeat failed approaches (no memory)
- Unclear if changes actually helped (no measurement)
- Good improvements reverted accidentally (no evidence)
- No learning from experiments (try-fail-forget cycle)
