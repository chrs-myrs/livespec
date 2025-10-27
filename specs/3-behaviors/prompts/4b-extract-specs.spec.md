---
specifies: prompts/4-evolve/4b-extract-specs.md
criticality: CRITICAL
failure_mode: New behaviors remain undocumented
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
  - specs/1-requirements/functional/drift-detection.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Extract Specifications

## Requirements
- [!] Prompt guides AI agent to extract MSL specifications from code changes or existing codebase, generating behavior and contract specs for undocumented functionality.
  - Produces specifications for undocumented behaviors (format: MSL with confidence markers for LOW/MEDIUM confidence extractions)
  - All new behaviors have specifications
  - Specs follow MSL format (criticality, failure_mode, Requirements with [!])
  - Specs describe WHAT (observable outcomes), not HOW (implementation)
  - Validation criteria are observable and testable
  - Low-confidence extractions marked with extraction metadata

## Context

Use when:
- Existing codebase lacks specifications
- New code added without specs (detected via drift detection)
- Need to document legacy system behaviors
- Retroactively creating LiveSpec documentation

## Prerequisites

- Codebase exists (code to analyze)
- `specs/3-behaviors/` directory created
- `specs/3-contracts/` directory created (if external interfaces exist)
- Agent understands MSL format
- Agent understands observable vs implementation distinction
- Agent understands confidence markers (see specs/workspace/patterns.spec.md)

## Outputs

- New `specs/3-behaviors/[domain]/[feature].spec.md` for extracted behaviors (format: MSL, with confidence markers and extraction metadata if LOW/MEDIUM confidence)
- Updated `specs/3-contracts/` for new external interfaces (format: OpenAPI/JSON Schema/AsyncAPI)
- Extraction metadata in frontmatter for low-confidence specs:
  - `extracted_from:` source files
  - `extracted_date:` ISO timestamp
  - `confidence:` LOW | MEDIUM (omit if HIGH)
  - `requires_validation:` true
  - `extraction_reason:` why confidence low

## Validation

- All undocumented behaviors now have specifications
- All specs follow MSL format (criticality, failure_mode, Requirements with [!])
- Specs describe observable outcomes (not implementation details)
- Validation criteria are testable
- Low-confidence extractions marked appropriately
- Specs traceable to source code (extraction metadata)

## Success Criteria

- Comprehensive coverage (all behaviors documented)
- Specs accurate (match actual code behavior)
- Confidence assessed honestly (LOW when unsure)
- Observable focus (testable from outside)
- Extraction traceable (can find source code)

## Error Handling

**If code behavior unclear:**
- Mark extraction as LOW confidence
- Document extraction_reason explaining ambiguity
- Use [?] markers for uncertain validation criteria
- Recommend Phase 4e for validation

**If no tests exist:**
- Mark as LOW confidence (cannot verify behavior)
- Infer behavior from code (best effort)
- Document lack of tests in extraction_reason

**If implementation details dominate:**
- Step back: Focus on observable outcomes
- Ask: "What does this do from user/system perspective?"
- Abstract away HOW, document WHAT

**If behavior seems internal (not external):**
- Question whether spec needed
- Internal implementation details don't need behavior specs
- Only extract observable behaviors

## Constraints

What this prompt should NOT do:
- ❌ Extract implementation details as behaviors (focus on observable outcomes)
- ❌ Mark LOW confidence as HIGH (honesty critical)
- ❌ Skip extraction metadata (traceability required)
- ❌ Create specs without validation criteria (must be testable)
- ❌ Extract every code function (only meaningful behaviors)
