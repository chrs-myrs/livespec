---
description: Spec health, validation, context generation, and continuous evolution
---

# Evolve

Manage specification health, run validation, regenerate context, and maintain the spec ecosystem.

## Usage

```
/livespec:evolve                     # Full evolution check
/livespec:evolve health              # Detailed health report
/livespec:evolve validate            # Run validation checks
/livespec:evolve audit [type]        # Quality audits (msl|scope|coverage)
/livespec:evolve context             # Regenerate AGENTS.md
/livespec:evolve extract             # Extract specs from code
```

## Modes

### (default) - Full Evolution Check

Runs health scan and reports status:

1. Checks structural health (frontmatter, sections)
2. Checks cross-references
3. Checks coverage (code vs specs)
4. Reports issues with fix suggestions
5. Offers to address findings

### health - Detailed Health Report

Comprehensive spec health dashboard:

- **Structural Health**: Frontmatter, Requirements, Validation sections
- **Cross-Reference Health**: All satisfies/guided-by links valid
- **MSL Compliance**: Line counts, no implementation details
- **Coverage**: Code files with/without specs

Outputs markdown report with remediation steps.

### validate - Run Validation Checks

Executes validation scripts:

- Cross-reference integrity
- Generated file protection
- MSL format compliance
- Folder structure correctness

Returns pass/fail with specific errors.

### audit [type] - Quality Audits

Deep quality analysis:

- `audit msl` - MSL minimalism compliance
- `audit scope` - Workspace scope clarity
- `audit coverage` - Spec coverage analysis

### context - Regenerate AGENTS.md

Rebuilds context from workspace specs:

1. Reads PURPOSE.md + specs/workspace/
2. Applies compression level from project.yaml
3. Structures with START/MIDDLE/END positioning
4. Generates AGENTS.md or CLAUDE.md
5. Validates under budget

### extract - Extract Specs from Code

For brownfield projects:

1. Finds unspecified code files
2. Analyzes behavior from implementation
3. Drafts specs with confidence markers
4. Presents for review and validation
5. Promotes validated extractions

## Health Indicators

| Status | Meaning |
|--------|---------|
| GREEN | All specs current, no gaps |
| YELLOW | 2+ stale specs, minor gaps |
| ORANGE | Broken references, MSL violations |
| RED | Coverage <50%, orphan specs |

## See Also

- `/livespec:design` - Create and refine specs
- `/livespec:learn` - Session completion and learning
