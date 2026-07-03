---
description: Spec health, validation, and context generation
routes-to: skills/audit/SKILL.md
---

# Audit

Manage specification health, run validation, and regenerate context.

## Usage

```
/livespec:audit                      # Full audit check
/livespec:audit health               # Detailed health report
/livespec:audit validate             # Run validation checks
/livespec:audit msl|scope|coverage   # Quality audits
/livespec:audit context              # Regenerate AGENTS.md
/livespec:audit extract              # Extract specs from code
```

## Modes

### (default) - Full Audit Check

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

### msl|scope|coverage - Quality Audits

Deep quality analysis:

- `msl` - MSL minimalism compliance
- `scope` - Workspace scope clarity
- `coverage` - Spec coverage analysis

### context - Regenerate AGENTS.md

Updates the context tree from workspace specs:

1. Classifies the change as MINOR (scoped patch to the affected file) or FULL (whole-tree rebuild), based on the Spec → Generated File Map in `specs/workspace/context-architecture.spec.md`
2. Reports the classification and reason, then proceeds — no confirmation gate
3. Delegates to `agents/context-builder.md`, which generates or patches only the classified scope
4. Validates output under budget

Force a full rebuild regardless of classification: `/livespec:audit context --full`

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
