---
description: Multi-project LiveSpec audit across your portfolio
routes-to: skills/sweep/SKILL.md
---

# Sweep

Discover, prioritise, analyse, and optionally remediate LiveSpec projects across `~/projects/`.

## Usage

```
/livespec:sweep                  # Default: tiered remediation
/livespec:sweep --conservative   # Report only, no auto-writes
/livespec:sweep --aggressive     # Auto-apply Tier 1+2, report Tier 3
/livespec:sweep --stale-days 30  # Custom staleness threshold
```

## What It Does

1. Discovers LiveSpec-adjacent projects under `~/projects/` (excluding `tmp/`)
2. Scores each by maintenance need (0-10, five signals)
3. Presents a prioritised target list for approval
4. Orchestrates parallel agents to audit (and optionally remediate) each project
5. Produces per-project issue files, a consolidated report, and a cross-project pattern meta-report

## See Also

- `/livespec:audit` - Single-project health checks and context generation
- `/livespec:design` - Create and refine specifications
