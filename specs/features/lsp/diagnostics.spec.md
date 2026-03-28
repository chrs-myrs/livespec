---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without accurate diagnostics, Claude Code cannot detect spec errors in real-time, allowing broken specs to persist
governed-by: []
satisfies:
  - specs/features/lsp/claude-code-plugin.spec.md
guided-by:
  - specs/interfaces/formats/msl-syntax.spec.md
  - specs/features/validation/cross-reference-validation.spec.md
---

# LSP Diagnostics

## Requirements

### Frontmatter Validation

- [!] LSP validates frontmatter structure and required fields
  - ERROR (E001): Missing `criticality` field
  - ERROR (E002): Missing `failure_mode` field
  - ERROR (E003): Invalid `criticality` value (must be CRITICAL or IMPORTANT)
  - ERROR (E004): Frontmatter not valid YAML
  - ERROR (E005): Missing frontmatter delimiters (`---`)

### Cross-Reference Validation

- [!] LSP validates all frontmatter path references exist
  - ERROR (E010): `satisfies` target file does not exist
  - ERROR (E011): `guided-by` target file does not exist
  - ERROR (E012): `governed-by` target file does not exist
  - ERROR (E013): `derives-from` target file does not exist
  - ERROR (E014): `supports` target file does not exist
  - ERROR (E015): `specifies` target file does not exist
  - Diagnostic includes: file path, line number, expected target path

### Document Structure Validation

- [!] LSP validates MSL document structure
  - ERROR (E020): Missing H1 title
  - ERROR (E021): Multiple H1 titles
  - ERROR (E022): Missing `## Requirements` section
  - WARNING (W020): Missing `## Validation` section
  - WARNING (W021): No `- [!]` markers in Requirements section

### Requirement Quality

- [!] LSP warns about incomplete requirements
  - WARNING (W030): Requirement without validation criteria (no indented bullets)
  - WARNING (W031): Very short failure_mode (< 20 characters)
  - INFO (I030): Spec has no relationship fields (isolated)

## Validation

- [ ] All ERROR diagnostics block pre-commit hooks
- [ ] All WARNING diagnostics are advisory
- [ ] Diagnostics include actionable fix suggestions
- [ ] Diagnostics update within 500ms of text change
- [ ] Diagnostics clear when issues are fixed

## Error Code Registry

| Code | Severity | Category | Description |
|------|----------|----------|-------------|
| E001 | ERROR | Frontmatter | Missing criticality |
| E002 | ERROR | Frontmatter | Missing failure_mode |
| E003 | ERROR | Frontmatter | Invalid criticality value |
| E004 | ERROR | Frontmatter | Invalid YAML |
| E005 | ERROR | Frontmatter | Missing delimiters |
| E010-E015 | ERROR | References | Broken cross-reference |
| E020 | ERROR | Structure | Missing H1 |
| E021 | ERROR | Structure | Multiple H1 |
| E022 | ERROR | Structure | Missing Requirements section |
| W020 | WARNING | Structure | Missing Validation section |
| W021 | WARNING | Structure | No requirement markers |
| W030 | WARNING | Quality | Requirement without criteria |
| W031 | WARNING | Quality | Short failure_mode |
| I030 | INFO | Quality | Isolated spec |
