---
specifies: prompts/3-verify/3b-acceptance-review.md
criticality: IMPORTANT
failure_mode: Stakeholders cannot assess if requirements are met
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Acceptance Review

## Requirements
- [!] Prompt guides AI agent to prepare acceptance review package using specifications as validation framework, presenting to stakeholders for approval.
  - Produces acceptance review package (format: markdown with problem recap, delivered behaviors, validation evidence, acceptance criteria checklist)
  - Review package references all specifications (traceability)
  - Stakeholders can assess against spec validation criteria
  - Acceptance decision documented (approved/conditionally approved/rejected)
  - Any conditions or outstanding issues clearly stated

## Context

Use when:
- After validation complete (Phase 3a done)
- Ready for stakeholder approval
- Before deployment/release
- Need formal acceptance of deliverables

## Prerequisites

- Implementation complete (Phase 2)
- Validation complete (Phase 3a with results)
- PURPOSE.md exists (original problem statement)
- specs/1-requirements/strategic/outcomes.spec.md exists (success criteria)
- Validation report available (proof of specification satisfaction)
- Stakeholders identified and available

## Outputs

- Acceptance review package (format: markdown with structured sections):
  - Problem recap (from PURPOSE.md)
  - Delivered behaviors (list of implemented features)
  - Validation evidence (test results, contract compliance, constraint satisfaction)
  - Acceptance criteria checklist (from outcomes.spec.md, each checked/unchecked)
  - Known issues or limitations
- Acceptance decision record (format: markdown with decision, conditions, sign-off):
  - Decision: Approved/Conditionally Approved/Rejected
  - Conditions (if conditionally approved)
  - Outstanding issues (if any)
  - Stakeholder sign-off

## Validation

- Review package references all key specifications (PURPOSE.md, outcomes.spec.md, behaviors/, constraints.spec.md)
- Stakeholders can assess against original success criteria (checklist provided)
- Acceptance decision documented (clear outcome)
- Any conditions for approval clearly stated
- Traceability maintained (can map delivered features to requirements)

## Success Criteria

- Review package complete (all sections present)
- Stakeholders understand what was delivered
- Evidence convincing (validation results clear)
- Decision recorded formally
- Conditions actionable (if conditional approval)

## Error Handling

**If validation incomplete:**
- Cannot proceed to acceptance review
- Guide back to Phase 3a: Complete validation first
- Explain stakeholders need evidence

**If stakeholders unavailable:**
- Document who needs to review
- Provide package for async review
- Set review deadline

**If acceptance rejected:**
- Document rejection reasons
- Map rejections to specifications (were specs unclear? implementation wrong?)
- Determine remediation path

**If conditions unclear:**
- Work with stakeholders to clarify
- Document specific acceptance criteria for conditions
- Create action items with owners

## Constraints

What this prompt should NOT do:
- ❌ Skip validation evidence (stakeholders need proof)
- ❌ Proceed with unfinished validation (must have Phase 3a results)
- ❌ Omit known issues (transparency required)
- ❌ Accept vague conditions (conditions must be specific and actionable)
- ❌ Skip formal decision record (acceptance must be documented)
