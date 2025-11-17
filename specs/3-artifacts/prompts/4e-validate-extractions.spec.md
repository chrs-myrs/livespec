---
specifies: prompts/4-evolve/4e-validate-extractions.md
derives-from:
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Low-confidence extractions remain unvalidated, specs diverge from implementation reality, extraction errors propagate
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/drift-detection.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Validate Extracted Specifications

## Requirements
- [!] Prompt guides human validation of extracted specifications marked with confidence metadata, enabling promotion from EXTRACTED to VALIDATED status.
  - Produces validated specifications (format: MSL with extraction metadata removed, standard frontmatter added)
  - Reviews accuracy against source code and tests
  - Three validation outcomes defined: PROMOTE / CORRECT / REJECT
  - Removes extraction markers ([?], confidence, requires_validation)
  - Adds standard frontmatter (derives-from, satisfies, governed-by)
  - Suggests test creation for untested behaviors
  - Prioritizes CRITICAL specs first

## Context

Use when:
- Specs with `confidence: LOW` or `MEDIUM` exist (from Phase 4b extraction)
- Specs containing `[?]` validation markers
- Specs with `requires_validation: true`
- Before merging extracted specs to main branch
- Periodic extraction validation sessions

## Prerequisites

- Extracted specs exist (from Phase 4b)
- Specs marked with confidence metadata
- Source code available for review
- Tests available (if they exist)
- Agent understands extraction markers (see specs/workspace/patterns.spec.md)
- Human reviewer available for validation decisions

## Outputs

- Validated specifications (format: MSL with extraction metadata removed, standard frontmatter):
  - **PROMOTE**: Accurate specs promoted (extraction frontmatter deleted, standard frontmatter added, [?] markers removed)
  - **CORRECT**: Fixed specs (corrections documented, then promoted)
  - **REJECT**: Invalid specs deleted (rejection reasoning in commit message)
- New tests for previously untested behaviors (format: follows workspace test patterns)
- Commit messages documenting validation (format: describes promotions, corrections, rejections)

## Validation

- All specs with confidence markers reviewed
- Validation decisions documented (PROMOTE/CORRECT/REJECT for each)
- Extraction frontmatter removed from validated specs
- Standard frontmatter added to validated specs
- [?] markers removed from all validated criteria
- CRITICAL specs prioritized (validated first)
- No extraction markers remain after validation complete

## Success Criteria

- All low-confidence extractions addressed
- Validated specs accurate (match code behavior)
- Extraction metadata appropriately removed
- Dependencies properly declared
- Test coverage improved (tests added for untested behaviors)

## Error Handling

**If spec accuracy unclear:**
- Mark as CORRECT (needs revision)
- Document specific uncertainties
- Review with domain expert
- Add tests to verify behavior

**If source code not found:**
- Cannot validate extraction
- Mark spec for investigation
- Check if code deleted or moved
- Consider REJECT if code doesn't exist

**If tests missing:**
- Note lack of test coverage
- Suggest test creation as part of validation
- Use code review for validation (less confident)
- Mark lower confidence if cannot verify

**If extraction completely wrong:**
- REJECT the spec
- Document why extraction failed
- Delete spec file
- Learn from extraction error for future

## Constraints

What this prompt should NOT do:
- ❌ Auto-promote without review (human validation required)
- ❌ Skip CRITICAL specs (priority order matters)
- ❌ Leave extraction markers (must clean up)
- ❌ Skip test creation suggestions (coverage important)
- ❌ Batch-promote without individual review (each spec needs assessment)
