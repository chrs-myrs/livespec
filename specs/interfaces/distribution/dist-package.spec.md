---
type: contract
category: interfaces
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without consistent dist package structure, target projects receive incomplete or malformed LiveSpec installations
governed-by: []
supports:
  - specs/features/context-generation.spec.md
---

# Distribution Package Contract

## Requirements

### Package Structure

- [!] dist/ package provides complete LiveSpec installation for target projects
  - Single copy operation (`cp -r dist/ .livespec/`) installs fully
  - No external dependencies required post-copy
  - All prompts, templates, and guides included
  - Bootstrap AGENTS.md included (instructs context generation)

### Required Contents

- [!] dist/ package contains all methodology components
  - Phase prompts (0-define/ through 4-evolve/)
  - Utility prompts (utils/)
  - Standard metaspecs (standard/metaspecs/)
  - Standard conventions (standard/conventions/)
  - Templates (templates/workspace/, templates/agents/)
  - Guides (guides/)
  - Bootstrap AGENTS.md (~5KB, not full context tree)
  - VERSION file (matches .livespec-version)

### Version Synchronization

- [!] Package version matches repository version
  - dist/VERSION matches root .livespec-version
  - All version indicators synchronized
  - Version bump updates all locations atomically

## Validation

- [ ] dist/ directory exists at repository root
- [ ] All phase prompt directories present (0-define through 4-evolve)
- [ ] utils/ prompt directory present
- [ ] standard/ directory contains metaspecs/ and conventions/
- [ ] templates/ directory contains workspace/ and agents/
- [ ] guides/ directory present with methodology guides
- [ ] AGENTS.md present (bootstrap version, ~5KB)
- [ ] VERSION file present and matches .livespec-version
