---
criticality: CRITICAL
failure_mode: Without consistent MSL format, specs become inconsistent, validation fails, and AI agents can't reliably parse requirements
governed-by:
  - .livespec/standard/metaspecs/contract.spec.md
supports:
  - specs/features/validation/
  - specs/artifacts/prompts/
---

# MSL Syntax Contract

## Requirements

### Document Structure

- [!] MSL specifications follow a four-section structure that enables consistent parsing and validation
  - YAML frontmatter block (required, between `---` delimiters)
  - H1 title (required, single line)
  - `## Requirements` section (required)
  - `## Validation` section (optional, recommended)

### Frontmatter Contract

- [!] Frontmatter contains structured metadata enabling traceability and tooling
  - `criticality`: CRITICAL | IMPORTANT (required)
  - `failure_mode`: Single sentence describing what breaks (required)
  - Relationship fields: `derives-from`, `satisfies`, `guided-by`, `governed-by`, `supports` (optional, arrays)
  - All paths are relative to repository root

### Requirements Syntax

- [!] Requirements use marker syntax for parseable extraction
  - `- [!]` prefix marks a requirement statement
  - Indented bullets below requirement are validation criteria
  - Requirements are concise WHAT statements, not HOW
  - Each requirement should be independently testable

### File Naming

- [!] Spec files follow naming convention for discoverability
  - Extension: `.spec.md`
  - Kebab-case: `context-generation.spec.md`
  - Descriptive names matching content

## Validation

- [ ] Frontmatter parses as valid YAML
- [ ] Exactly one H1 heading exists
- [ ] `## Requirements` section present
- [ ] At least one `- [!]` marker in requirements
- [ ] `criticality` and `failure_mode` present in frontmatter
- [ ] File extension is `.spec.md`
