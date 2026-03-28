---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without navigation, Claude Code cannot efficiently traverse spec relationships, slowing understanding of spec dependencies
governed-by: []
satisfies:
  - specs/features/lsp/claude-code-plugin.spec.md
guided-by:
  - specs/interfaces/formats/msl-syntax.spec.md
---

# LSP Navigation

## Requirements

### Go to Definition

- [!] LSP provides jump-to-definition for all frontmatter references
  - Cursor on path in `satisfies:` → Jump to target spec
  - Cursor on path in `guided-by:` → Jump to target spec
  - Cursor on path in `governed-by:` → Jump to target spec
  - Cursor on path in `derives-from:` → Jump to target spec
  - Cursor on path in `supports:` → Jump to target spec
  - Cursor on path in `specifies:` → Jump to target file
  - Returns null location for non-existent targets (diagnostic handles error)

### Find References

- [!] LSP finds all specs that reference the current spec
  - Find all specs with `satisfies:` pointing to current file
  - Find all specs with `guided-by:` pointing to current file
  - Find all specs with `governed-by:` pointing to current file
  - Find all specs with `derives-from:` pointing to current file
  - Find all specs with `supports:` pointing to current file
  - Results include file path and line number of each reference

### Document Symbols

- [!] LSP provides document outline for spec structure
  - H1 title as root symbol
  - H2 sections as child symbols (Requirements, Validation, Examples)
  - `- [!]` requirement markers as leaf symbols
  - Symbol kind: H1=Class, H2=Method, Requirement=Property

### Workspace Symbols

- [!] LSP provides project-wide spec search
  - Search by spec filename
  - Search by H1 title content
  - Returns all matching `.spec.md` files in workspace
  - Sorted by relevance (exact match first, then partial)

## Validation

- [ ] Go to Definition works for all reference types
- [ ] Find References returns complete list (no false negatives)
- [ ] Document Symbols shows correct hierarchy
- [ ] Workspace Symbols responds within 200ms
- [ ] Navigation works across entire workspace (not just open files)
