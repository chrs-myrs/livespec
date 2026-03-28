---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without spec health monitoring, specifications become outdated, bloated, or inconsistent
governed-by: []
satisfies: []
guided-by: []
---

# Spec Health Behavior

## Requirements
- [!] LiveSpec monitors spec health through structural validation, MSL compliance, and cross-reference integrity, identifying issues that degrade spec quality.
  - Spec validation detects structural issues (missing sections, broken links)
  - MSL audit identifies bloated or over-specified specs
  - Cross-reference validation ensures bidirectional linking works
  - AI agents guide spec remediation through EVOLVE mode
  - Human review focuses only on ambiguous cases

## Health Indicators

Spec health monitoring detects:
- **Structural issues**: Missing required sections, invalid frontmatter
- **MSL violations**: Over-specification, implementation details in specs
- **Broken references**: Invalid frontmatter links, orphaned specs
- **Stale specs**: Specs no longer relevant to project
- **Bloat**: Specs that have grown beyond MSL minimalism targets

## Resolution Categories

### Auto-Fix (70-80% of issues)
- Missing frontmatter fields
- Broken cross-references with clear fix
- Formatting inconsistencies
- Minor structural issues

### Review Needed (10-20% of issues)
- MSL violations requiring judgment
- Specs with unclear purpose
- Potential duplicates
- Significant structural problems

### Manual Resolution (5-10% of issues)
- Conflicting spec relationships
- Ambiguous spec boundaries
- Critical foundation spec issues
- Multi-spec refactoring needed
