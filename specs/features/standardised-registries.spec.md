---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without standardised registry format, registries have inconsistent structure preventing automated aggregation and reducing audit scores on structural consistency
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
derives-from:
  - docs/registries/improvements.md (IMP-008)
---

# Standardised Registry Format

## Requirements

### Registry Frontmatter Schema

- [!] All registry files carry YAML frontmatter with a consistent schema that makes them machine-parseable and self-describing.
  - `store: registry` field identifying the file as a registry
  - `registry_type` field classifying the registry (gaps, issues, improvements, decisions, debt, risks)
  - `schema_version` field for format versioning (integer, starting at 1)
  - `last_reviewed` field with ISO date of last human review
  - `entry_count` field with current number of entries

### Consistent Entry Structure

- All registry entries within a type follow the same field pattern defined by their registry format spec.
  - Each entry has a unique identifier (e.g., GAP-001, ISSUE-001, IMP-001)
  - Each entry has a status field from a controlled vocabulary
  - Status values documented in `references/standards/vocabulary.spec.md`

### Format Spec Reference

- Each registry file references its format specification in the frontmatter `format` field.
  - Points to the registry format spec that defines entry structure

## Validation

- [ ] All registry files in `docs/registries/` have YAML frontmatter
- [ ] Frontmatter includes store, registry_type, schema_version, last_reviewed, entry_count
- [ ] Entry identifiers are unique within each registry
- [ ] Status values match controlled vocabulary
