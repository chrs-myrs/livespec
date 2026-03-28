---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without LSP integration, Claude Code lacks real-time feedback on spec validity, slowing development and allowing errors to persist
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/interfaces/formats/msl-syntax.spec.md
supports:
  - specs/features/validation/cross-reference-validation.spec.md
---

# Claude Code LSP Plugin

## Requirements

### Plugin Distribution

- [!] LiveSpec provides a Claude Code plugin that integrates LSP capabilities for `.spec.md` files
  - Plugin installable via `claude plugin add livespec-lsp`
  - Plugin configures language server connection (stdio transport)
  - Language server binary distributed separately (npm, cargo, or standalone)
  - Plugin activates for files matching `*.spec.md` pattern

### Real-Time Diagnostics

- [!] Claude Code receives instant diagnostics after editing spec files
  - ERROR: Missing required frontmatter fields (criticality, failure_mode)
  - ERROR: Broken cross-references (satisfies:, guided-by:, governed-by: pointing to non-existent files)
  - ERROR: Invalid frontmatter YAML syntax
  - WARNING: Missing recommended sections (## Validation)
  - WARNING: Requirements without validation criteria (- [!] without indented bullets)
  - INFO: Specs without any relationship fields (isolated specs)

### Navigation

- [!] Claude Code can navigate spec relationships via LSP
  - Go to Definition: Jump from frontmatter reference to target spec
  - Find References: Find all specs that reference current spec
  - Document Symbols: Outline showing Requirements, Validation sections
  - Workspace Symbols: Find specs by name across project

### Completions

- [!] Claude Code receives context-aware completions while editing specs
  - Frontmatter keys: `criticality`, `failure_mode`, `satisfies`, `guided-by`, etc.
  - Criticality values: `CRITICAL`, `IMPORTANT`
  - Spec paths: Relative paths to existing `.spec.md` files
  - Section headers: `## Requirements`, `## Validation`, `## Examples`

## Validation

- [ ] Plugin installs without errors in Claude Code
- [ ] Diagnostics appear within 500ms of file edit
- [ ] Go to Definition works for all frontmatter reference types
- [ ] Completions include all existing spec paths in workspace
- [ ] Plugin gracefully handles missing language server binary

## Integration Points

**With existing validation scripts:**
- LSP diagnostics mirror `scripts/validate-*.sh` output
- LSP provides real-time; scripts provide batch/CI validation
- Same error codes and messages for consistency

**With Claude Code agent workflow:**
- Diagnostics visible immediately after Claude edits spec
- Claude can use Go to Definition to understand spec relationships
- Find References helps Claude understand impact of changes
