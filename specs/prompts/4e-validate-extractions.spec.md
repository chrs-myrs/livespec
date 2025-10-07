---
specifies: prompts/4-evolve/4e-validate-extractions.md
derives_from:
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Low-confidence extractions remain unvalidated, specs diverge from implementation reality, extraction errors propagate
---

# Validate Extracted Specifications Prompt

## Requirements
- Prompt guides human validation of extracted specifications marked with confidence metadata, enabling promotion from EXTRACTED to VALIDATED status by reviewing accuracy, correcting errors, and removing extraction markers.

**Triggers:**
- Specs with `confidence: LOW` or `MEDIUM` frontmatter
- Specs containing `[?]` validation markers
- Specs with `requires_validation: true`
- Before merging extracted specs to main branch

**Process:**
1. Find specs needing validation (grep for confidence markers)
2. Review each spec against source code and tests
3. Make validation decision (PROMOTE / CORRECT / REJECT)
4. Remove extraction metadata, add standard frontmatter
5. Add test coverage for previously untested behaviors
6. Update dependency declarations

**Validation outcomes:**
- PROMOTE: Extraction accurate → remove markers, add dependencies
- CORRECT: Fix errors → then remove markers
- REJECT: Invalid extraction → delete spec, document reasoning
  - Prompt provides clear validation criteria (accuracy, completeness, MSL compliance)
  - Prompt defines three validation outcomes (PROMOTE/CORRECT/REJECT)
  - Prompt includes checklist for validation review
  - Prompt guides frontmatter updates (remove extraction, add dependencies)
  - Prompt suggests test creation for untested behaviors
  - Prompt includes batch validation workflow for efficiency
  - Prompt provides prioritization guidance (CRITICAL first)
  - Exit criteria verify all extraction markers removed

## Prompt Outputs

**Primary outputs:**
- Validated specs (extraction markers removed)
- Standard frontmatter (derives_from, satisfies, constrained_by)
- New tests for previously untested behaviors
- Commit messages documenting corrections

**For PROMOTE:**
- Extraction frontmatter deleted
- Standard frontmatter added
- `[?]` markers removed
- `⚠️` EXTRACTION NOTES removed
- Criticality qualifier ("estimated") removed if accurate

**For CORRECT:**
- Specification corrections documented
- Errors fixed before promotion
- Commit message lists corrections made

**For REJECT:**
- Spec file deleted
- Rejection reasoning in commit message

## Validation

- Prompt provides clear validation criteria (accuracy, completeness, MSL compliance)
- Prompt defines three validation outcomes (PROMOTE/CORRECT/REJECT)
- Prompt includes checklist for validation review
- Prompt guides frontmatter updates (remove extraction, add dependencies)
- Prompt suggests test creation for untested behaviors
- Prompt includes batch validation workflow for efficiency
- Prompt provides prioritization guidance (CRITICAL first)
- Exit criteria verify all extraction markers removed
