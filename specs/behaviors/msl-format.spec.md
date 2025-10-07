---
criticality: CRITICAL
failure_mode: Without MSL format, specifications bloat and become maintenance burdens
derives_from:
  - https://github.com/chrs-myrs/msl-specification
---

# MSL Format Behavior

## Requirements
- [!] All LiveSpec specifications follow MSL (Markdown Specification Language) format from github.com/chrs-myrs/msl-specification.
  - All .spec.md files have title and `## Requirements` section
  - YAML frontmatter declares metadata (criticality, failure_mode, dependencies)
  - LiveSpec uses custom frontmatter fields: `criticality`, `failure_mode`
  - Requirement markers used: `[!]` (critical), `[?]` (needs validation), `[x]` (implemented), `[ ]` (pending)
  - Optional sections allowed: `## Summary`, `## Notes`, domain-specific sections
  - Specifications are minimal and testable
  - No "nice to have" or "should" requirements exist
  - Every specification can answer: "Would the system fail without this?"

## Notes

LiveSpec extends MSL with two custom frontmatter conventions:

**criticality:** CRITICAL | IMPORTANT
- CRITICAL: System fails without this requirement
- IMPORTANT: Quality degrades without this requirement

**failure_mode:** Concrete description of what breaks if requirement not met

These fields supplement MSL's standard frontmatter (derives_from, constrained_by, satisfies, supports, applies_to).

For full MSL specification, see: https://github.com/chrs-myrs/msl-specification
