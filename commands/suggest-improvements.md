---
description: Strategic improvement recommendations from accumulated data
argument-hint: [all|context|registries|validation]
---

# Suggest Improvements

Analyze accumulated feedback data and provide prioritized improvement recommendations.

## Usage

- `/livespec:suggest-improvements` - Full analysis (default)
- `/livespec:suggest-improvements context` - Context efficiency only
- `/livespec:suggest-improvements registries` - Registry health only
- `/livespec:suggest-improvements validation` - Validation pass rates only

## Data Sources

Analyzes:
- `~/.claude/livespec/compliance/*.json` - Session compliance trends
- `~/.claude/livespec/feedback/*.md` - Session feedback
- `docs/registries/gaps.md` - Methodology gaps (if exists)
- `docs/registries/issues.md` - Known issues (if exists)
- `docs/registries/improvements.md` - Tried improvements (if exists)

## Analysis Scopes

### all (default)
Full analysis across all areas with cross-referencing.

### context
Context efficiency only:
- AGENTS.md size trends
- Compression effectiveness
- Signal-to-noise ratios
- Redundancy patterns

### registries
Registry health only:
- Gap accumulation rate
- Issue resolution rate
- Improvement success rate
- Pattern detection

### validation
Validation pass rates only:
- Compliance trends (last 5-10 sessions)
- Common failure modes
- Layer-by-layer breakdown
- Focus efficiency patterns

## Scoring

Improvements prioritized by: **Impact × Frequency**

- High impact, high frequency → Immediate priority
- High impact, low frequency → Important but targeted
- Low impact, high frequency → Quick wins
- Low impact, low frequency → Nice to have

## Report Format

```markdown
# Improvement Recommendations

**Analysis Date:** YYYY-MM-DD
**Sessions Analyzed:** X
**Scope:** [all/context/registries/validation]

## Priority 1 (Immediate)
[High impact × High frequency items]

## Priority 2 (Important)
[High impact × Low frequency items]

## Quick Wins
[Low impact × High frequency items]

## Trends
[Improving/declining patterns]
```

## When to Use

- Monthly reviews
- After multiple sessions accumulated
- When methodology feels suboptimal
- Before planning methodology changes
- Investigating recurring issues

## References

For detailed improvement analysis:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/suggest-improvements.md`
