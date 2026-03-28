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

**Decision:** Keep ✓

**Evaluation Date:** 2025-11-20 (1 week), 2025-12-13 (1 month)

**Outcome (2025-12-15):** Effective - No terminology confusion reported in 18 feedback files post-implementation. ISSUE-004 can be closed.

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

**Decision:** Accepted as Limitation

**Evaluation Date:** 2025-11-20 (immediate impact), 2025-12-13 (sustained)

**Baseline Metrics:**
- Current proactive detection: ~0% (manual only)
- Average session tokens: 127K (evidence: 2025-11-08)
- User-initiated: 100%

**Outcome (2025-12-15):** Ineffective for proactive detection (1/18 sessions). However, stronger enforcement would compete with more critical guidance (spec-first protocol). Decision: Accept session completion as user-initiated by design. The workflow works well when used. GAP-001/ISSUE-003 closed as accepted limitations.

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

**Decision:** Keep ✓

**Evaluation Date:** 2025-11-20 (1 week), 2025-12-13 (1 month)

**Related:** IMP-001 (part of larger taxonomy improvement)

**Outcome (2025-12-15):** Effective - Sessions that complete properly (Nov 21 choirwick, Nov 29 choirwick) show rich "Session Learnings" and "Improvements Made" sections. The consolidated workflow works when sessions complete.

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

**Decision:** Keep ✓

**Evaluation Date:** 2025-12-13 (1 month - needs time to accumulate data)

**Meta Note:** This improvement tracks itself - effectiveness measured by registry utility

**Outcome (2025-12-15):** Effective - This very analysis proves the value. Pattern detection across 25 compliance records and 18 feedback files identified IMP-002 failure and confirmed IMP-001/003/004 success. Registries enable systematic improvement evaluation.

---

### IMP-005: Mandatory Spec Frontmatter

**Changed:** Added mandatory YAML frontmatter to base metaspec: type (subtype classification implying metaspec template), category (directory-level), fidelity (detail level), criticality, failure_mode, governed-by (content governance only). Per-category mandatory fields added. governed-by semantics changed from dual-purpose to content-only (type implies format governance).

**Hypothesis:** Specs without frontmatter score 1/5 on machine-readability (B1) and 1/5 on frontmatter completeness (A1) in knowledge store audits. Adding structured frontmatter will make specs self-describing and machine-navigable without relying on AGENTS.md or taxonomy.spec.md as intermediaries.

**Category:** Structure

**Implemented:** 2026-03-28

**Evidence:**
- Audit of affiliate-api-v2 (LiveSpec v5 project): 61/100 overall (C grade)
- Hand-built stores with frontmatter conventions: 84/100 (B+ grade)
- 23-point gap driven primarily by A1 (1/5) and B1 (1/5)
- Projected impact: +6 points on static audit
- Source: `research/reports/knowledge-store-audit-findings.md`

**Decision:** Implemented ✓

**Implementation Details:**
- 117 spec files transformed with new frontmatter schema
- Validation script: `scripts/validate-frontmatter.sh` (0 errors, 0 warnings)
- Base metaspec updated: `references/standards/metaspecs/base.spec.md`
- All 12 type-specific metaspecs updated
- Spec: `specs/features/mandatory-frontmatter.spec.md`
- Plan: `var/seek/20260328-134249-imp005-mandatory-frontmatter/SUMMARY.md`

**Evaluation Date:** 2026-04-11 (2 weeks), 2026-04-28 (1 month)

---

### IMP-006: Vocabulary Spec as Standard Deliverable

**Changed:** (Proposed) Create a vocabulary-spec template that every LiveSpec project generates during scaffolding, defining: spec categories, fidelity levels, criticality levels, registry severity/status values

**Hypothesis:** Projects using controlled vocabularies without definitions achieve 70-80% correct usage; projects with full vocabulary specs achieve 100%. LiveSpec currently scores 0/5 on vocabulary definition (B6) because no vocabulary documentation exists as a standard deliverable.

**Category:** Structure

**Implemented:** Not yet

**Evidence:**
- R2 Experiment 4B: Vocab spec 20/20 vs examples 16/20 vs teaching 14/20
- Discriminating dimension: reliability reasoning (source vs conduit distinctions require full definitions)
- affiliate-api-v2 audit: B6 = 0/5 (no vocabulary documentation)
- Projected impact: +4 points on static audit
- Source: `research/reports/knowledge-store-audit-findings.md`

**Decision:** Pending

---

### IMP-007: Distributed Cross-References in Spec Frontmatter

**Changed:** (Proposed) Each spec carries `governed-by`, `derives-from`, and `specifies` in frontmatter. The taxonomy mapping table becomes a derived view of these distributed references, not the source of truth.

**Hypothesis:** Centralised traceability (a mapping table in taxonomy.spec.md) breaks when specs are read individually. Distributed metadata (each spec declares its own relationships) enables automated graph traversal and reverse lookups without parsing prose.

**Category:** Traceability

**Implemented:** Not yet

**Evidence:**
- affiliate-api-v2 audit: A4 = 3/5 (references exist but not machine-parseable), B5 = 3/5 (no reverse traceability)
- Referenced traceability-matrix.md doesn't exist in the audited project
- Hand-built stores (clark-v-mauro) with distributed references: B5 = 5/5
- Projected impact: +2 points on static audit
- Source: `research/reports/knowledge-store-audit-findings.md`

**Decision:** Pending

---

### IMP-008: Standardised Registry Format

**Changed:** (Proposed) All registries (decisions, debt, known-issues, data-protection-risks) use the same YAML frontmatter schema: `store: registry`, `type: <registry-type>`, `schema_version`, `last_reviewed`, `entries[]`

**Hypothesis:** Inconsistent registry formats (2/4 with YAML frontmatter, 2/4 without) reduce structural consistency and prevent automated registry aggregation.

**Category:** Structure

**Implemented:** Not yet

**Evidence:**
- affiliate-api-v2 audit: A5 = 2/5 (varied structures within types)
- decisions.md and debt.md have YAML frontmatter; known-issues.md and data-protection-risks.md don't
- Projected impact: +2 points on static audit
- Source: `research/reports/knowledge-store-audit-findings.md`

**Decision:** Pending

---

### IMP-009: Fidelity Level as Spec Metadata

**Changed:** (Proposed) Each spec carries its fidelity level in frontmatter (`fidelity: full-detail | behavioral | decisions-only | process`) rather than relying on constitution.spec.md prose guidance

**Hypothesis:** When fidelity levels are only in the constitution, agents reading a single spec cannot know what level of detail is expected without reading the constitution first. Metadata-level fidelity enables automated enforcement and self-describing specs.

**Category:** Governance

**Implemented:** Not yet

**Evidence:**
- affiliate-api-v2 audit: B7 = 2/5 (implicit gradient, not metadata)
- Constitution.spec.md defines fidelity per category but it's not enforced by frontmatter
- Projected impact: +2 points on static audit
- Source: `research/reports/knowledge-store-audit-findings.md`

**Decision:** Pending

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
