---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without completions, Claude Code must guess at valid values and paths, increasing errors and slowing spec authoring
governed-by: []
satisfies:
  - specs/features/lsp/claude-code-plugin.spec.md
guided-by:
  - specs/interfaces/formats/msl-syntax.spec.md
---

# LSP Completions

## Requirements

### Frontmatter Key Completions

- [!] LSP suggests frontmatter keys when cursor is in frontmatter block
  - Required keys: `criticality`, `failure_mode`
  - Relationship keys: `satisfies`, `guided-by`, `governed-by`, `derives-from`, `supports`, `specifies`
  - Keys already present are excluded from suggestions
  - Completion includes snippet with cursor positioning

### Criticality Value Completions

- [!] LSP suggests valid criticality values
  - Trigger: After `criticality:`
  - Options: `CRITICAL`, `IMPORTANT`
  - Include description in completion detail

### Spec Path Completions

- [!] LSP suggests existing spec paths for relationship fields
  - Trigger: After `satisfies:`, `guided-by:`, `governed-by:`, `derives-from:`, `supports:`
  - Scope: All `.spec.md` files in workspace
  - Format: Relative path from repository root
  - Sorted: By path proximity (same directory first, then alphabetical)
  - Exclude: Current file from suggestions

### Section Header Completions

- [!] LSP suggests standard section headers
  - Trigger: `## ` at start of line (outside frontmatter)
  - Options: `Requirements`, `Validation`, `Examples`, `Failure Scenarios`
  - Exclude sections already present in document

### Requirement Marker Completions

- [!] LSP suggests requirement syntax
  - Trigger: `- ` at start of line in Requirements section
  - Options: `[!] ` (requirement marker)
  - Include snippet for requirement with validation criteria template

## Validation

- [ ] Frontmatter key completions appear in frontmatter only
- [ ] Spec path completions include all workspace specs
- [ ] Completions respect already-present content
- [ ] Completion response time < 100ms
- [ ] Snippets position cursor correctly after insertion

## Completion Snippets

**Requirement with criteria:**
```
[!] ${1:Requirement description}
  - ${2:Validation criterion 1}
  - ${3:Validation criterion 2}
```

**New frontmatter block:**
```
---
criticality: ${1|CRITICAL,IMPORTANT|}
failure_mode: ${2:What breaks without this}
---
```
