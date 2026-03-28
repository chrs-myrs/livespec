---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without vocabulary definitions, agents and users interpret controlled terms inconsistently, achieving 70-80% correct usage vs 100% with full definitions
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 1: Specification-first development)
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
derives-from:
  - docs/registries/improvements.md (IMP-006)
  - research/reports/knowledge-store-audit-findings.md
---

# Vocabulary Spec as Standard Deliverable

## Requirements

### Vocabulary Coverage

- [!] A vocabulary spec documents every controlled value used in LiveSpec frontmatter, relationship fields, phases, layers, and registries.
  - Frontmatter field values: type (15 values), category (6 values), fidelity (4 values), criticality (2 values)
  - Relationship field names with direction semantics (up, down, sideways, backward)
  - Phase vocabulary (5 phases with number, name, and purpose)
  - Layer vocabulary (3 layers with number, name, and scope)
  - Registry vocabularies (severity, status, decision outcomes, improvement categories)
  - Requirement markers ([!] critical, document-level vs requirement-level distinction)
  - Each value has description, usage context, and at least one example

### Distribution

- [!] The vocabulary spec is distributed as a standard deliverable so target projects receive it automatically.
  - Located in `references/standards/vocabulary.spec.md`
  - Included in dist/ packaging alongside metaspecs
  - Available to agents without loading additional context

### Extensibility

- [!] Projects can extend the core vocabulary with domain-specific values without forking the standard.
  - Extension mechanism documented in the vocabulary spec
  - Projects add domain-specific values in `specs/workspace/vocabulary.spec.md`
  - Project vocabulary spec declares relationship to core vocabulary
  - Validation accepts both core and extended values

### Consistency with Enforcement

- The vocabulary spec is the canonical source of truth for controlled values, consistent with enforcement in `scripts/validate-frontmatter.sh`.
  - Validation script values match vocabulary spec values
  - Vocabulary spec referenced as source in validation script comments

## Validation

- [ ] `references/standards/vocabulary.spec.md` exists
- [ ] All IMP-005 frontmatter values documented with descriptions
- [ ] Relationship fields documented with direction semantics
- [ ] Phase and layer vocabularies documented
- [ ] Registry vocabularies documented
- [ ] Extension mechanism documented with example
- [ ] Included in dist/ packaging
- [ ] B6 audit dimension improves from 0/5 baseline
