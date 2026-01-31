---
description: Run quality audits on project specifications
argument-hint: [minimalism|context|coverage|workspace-specs|workspace-scope|all]
---

# Audit Project

Run quality audits on LiveSpec project specifications.

## Usage

- `/livespec:audit` - Run all audits (default)
- `/livespec:audit minimalism` - Check MSL compliance
- `/livespec:audit context` - Analyze context compression
- `/livespec:audit coverage` - Verify spec coverage
- `/livespec:audit workspace-specs` - Detect workspace bloat
- `/livespec:audit workspace-scope` - Verify scope appropriateness

## Audit Types

### minimalism
Check specs for over-specification using MSL principles (4 essential questions):
1. Is this essential? (Would system fail without it?)
2. Am I specifying HOW instead of WHAT?
3. What specific problem does this prevent?
4. Could this be inferred or conventional?

Report specs that violate minimalism with specific recommendations.

### context
Analyze context compression effectiveness:
- AGENTS.md size vs target (30-40KB)
- Extraction ratio (inline vs referenced)
- Redundancy detection
- Compression level appropriateness

### coverage
Verify all permanent files have specifications:
- Scan src/, lib/, scripts/ for unspecified files
- Check specs/features/ for orphaned specs
- Report coverage percentage

### workspace-specs
Detect bloat/redundancy in workspace specs:
- constitution.spec.md size check
- patterns.spec.md duplication
- workflows.spec.md clarity
- Overlapping requirements

### workspace-scope
Verify workspace scope appropriateness:
- Product-specific content not in workspace/
- Operating context correctly identified
- Deliverables in numbered specs

### all (default)
Run all 5 audit types sequentially and aggregate results.

## Report Format

```markdown
# Audit Report

**Date:** YYYY-MM-DD
**Audits Run:** [list]

## Summary
- Errors: X
- Warnings: X
- Passed: X

## [Audit Type] Results
[Findings and recommendations]
```

## When to Use

- Monthly reviews
- Before releases
- When specs feel bloated
- Investigating project health
- Quality assurance process

## References

For detailed audit procedures:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/audit-msl-minimalism.md`
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/audit-context-compression.md`
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/audit-spec-coverage.md`
