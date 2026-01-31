---
description: Comprehensive project health check with status indicators
---

# Health Report

Generate comprehensive project health dashboard with status indicators and remediation recommendations.

## When to Use

- Monthly health checks
- Before releases
- When project feels "off"
- After major changes
- Onboarding new contributors

## Health Categories

### Validation Health (0-100%)

Run validation checks:
1. Taxonomy structure
2. Workspace scope
3. Spec purity
4. Architecture alignment
5. Cross-references
6. Generated files
7. Version sync

Score = (passing / total) x 100%

### Compliance Health (0-100%)

Analyze last 5 session compliance files from `~/.claude/livespec/compliance/`:
- Average overall compliance
- Trend (improving/stable/declining)

### Context Health (0-100%)

Check AGENTS.md and context sizes:
- AGENTS.md size vs 30-40KB target
- Context tree total size
- Compression level appropriateness

### Registry Health (0-100%)

If using registries (gaps.md, issues.md, improvements.md):
- Gap accumulation rate
- Issue resolution rate
- Improvement success rate

## Status Levels

For each category:
- **GREEN**: >= 85%
- **YELLOW**: 60-84%
- **RED**: < 60%

## Report Format

```markdown
# Project Health Report

**Generated:** YYYY-MM-DD
**Project:** [name]
**Overall Health:** [status] XX%

| Category | Status | Score | Trend |
|----------|--------|-------|-------|
| Validation | [icon] | XX% | [arrow] |
| Compliance | [icon] | XX% | [arrow] |
| Context | [icon] | XX% | [arrow] |

## Critical Issues (Immediate Action)
[RED items]

## Warnings (Address Soon)
[YELLOW items]

## Strengths (Keep Doing)
[GREEN categories]

## Remediation Plan
[Specific fixes for each issue]
```

## References

For detailed health reporting:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/run-health-report.md`
